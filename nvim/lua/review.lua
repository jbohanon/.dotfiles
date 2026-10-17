-- PR triage: use difftastic to find files whose changes are purely
-- cosmetic (formatting, pure renames) plus known-noisy paths (lockfiles,
-- generated code), and mark them "viewed" on GitHub. Octo's file panel then
-- only needs `]u` (next unviewed) to walk the meaningful changes.
local M = {}

M.noise_patterns = {
    "%.lock$", "^package%-lock%.json$", "/package%-lock%.json$", "^go%.sum$", "/go%.sum$",
    "^yarn%.lock$", "^pnpm%-lock%.yaml$", "%.snap$", "/__snapshots__/", "/testdata/golden/",
    "%.pb%.go$", "_pb2%.py$", "%.generated%.", "_generated%.", "^vendor/", "/vendor/",
    "%.min%.js$", "^dist/", "/dist/",
}

local function is_noise_path(path)
    for _, p in ipairs(M.noise_patterns) do
        if path:match(p) then return true end
    end
    return false
end

local function run(cmd, opts)
    local res = vim.system(cmd, vim.tbl_extend("force", { text = true }, opts or {})):wait()
    return res
end

local function git(args)
    local res = run(vim.list_extend({ "git" }, args))
    if res.code ~= 0 then return nil, res.stderr end
    return res.stdout
end

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO, { title = "PRTriage" })
end

local function pr_info()
    local res = run({ "gh", "pr", "view", "--json", "id,number,baseRefName,headRefOid" })
    if res.code ~= 0 then
        return nil, "No PR for the current branch (run :Octo pr checkout first): " .. vim.trim(res.stderr)
    end
    return vim.json.decode(res.stdout)
end

local function blob_to_tmp(rev, path, tmp)
    local res = run({ "git", "show", rev .. ":" .. path })
    if res.code ~= 0 then return nil end
    local f = assert(io.open(tmp, "wb"))
    f:write(res.stdout)
    f:close()
    return tmp
end

-- true when difftastic finds no syntactic change between the two revisions
local function cosmetic_only(base, head, old_path, new_path)
    if vim.fn.executable("difft") == 0 then return false end
    local a = blob_to_tmp(base, old_path, vim.fn.tempname() .. "." .. vim.fn.fnamemodify(old_path, ":e"))
    local b = blob_to_tmp(head, new_path, vim.fn.tempname() .. "." .. vim.fn.fnamemodify(new_path, ":e"))
    if not (a and b) then return false end
    local res = run({ "difft", "--check-only", "--exit-code", "--color=never", a, b })
    os.remove(a)
    os.remove(b)
    return res.code == 0
end

-- Returns { meaningful = {...}, noise = { {path=, reason=}, ... } }
function M.classify(pr)
    local upstream = "origin/" .. pr.baseRefName
    local base = git({ "merge-base", upstream, pr.headRefOid })
    if not base then
        git({ "fetch", "origin", pr.baseRefName })
        base = git({ "merge-base", upstream, pr.headRefOid })
    end
    if not base then return nil, "Could not find merge-base with " .. upstream end
    base = vim.trim(base)

    local out = git({ "diff", "--name-status", "-M", "-z", base .. ".." .. pr.headRefOid })
    if not out then return nil, "git diff failed" end

    local fields = vim.split(out, "\0", { plain = true, trimempty = true })
    local result = { meaningful = {}, noise = {} }
    local i = 1
    while i <= #fields do
        local status = fields[i]
        local kind = status:sub(1, 1)
        local old_path, new_path
        if kind == "R" or kind == "C" then
            old_path, new_path = fields[i + 1], fields[i + 2]
            i = i + 3
        else
            old_path = fields[i + 1]
            new_path = old_path
            i = i + 2
        end

        if is_noise_path(new_path) then
            table.insert(result.noise, { path = new_path, reason = "noisy path" })
        elseif status == "R100" then
            table.insert(result.noise, { path = new_path, reason = "pure rename" })
        elseif kind == "M" or kind == "R" then
            if cosmetic_only(base, pr.headRefOid, old_path, new_path) then
                table.insert(result.noise, { path = new_path, reason = "no syntactic change" })
            else
                table.insert(result.meaningful, new_path)
            end
        else
            table.insert(result.meaningful, new_path)
        end
    end
    return result
end

local mark_query = [[
mutation($id: ID!, $path: String!) {
  markFileAsViewed(input: {pullRequestId: $id, path: $path}) { clientMutationId }
}]]

local function mark_viewed(pr_id, path)
    local res = run({
        "gh", "api", "graphql",
        "-f", "query=" .. mark_query,
        "-f", "id=" .. pr_id,
        "-f", "path=" .. path,
    })
    return res.code == 0
end

function M.triage(cb)
    local pr, err = pr_info()
    if not pr then return notify(err, vim.log.levels.ERROR) end
    if vim.fn.executable("difft") == 0 then
        notify("difft not found on PATH; only path-based noise will be filtered", vim.log.levels.WARN)
    end

    notify(("Classifying PR #%d..."):format(pr.number))
    local result, cerr = M.classify(pr)
    if not result then return notify(cerr, vim.log.levels.ERROR) end

    local marked, lines = 0, {}
    for _, n in ipairs(result.noise) do
        if mark_viewed(pr.id, n.path) then marked = marked + 1 end
        table.insert(lines, ("  viewed  %s (%s)"):format(n.path, n.reason))
    end
    for _, p in ipairs(result.meaningful) do
        table.insert(lines, ("  REVIEW  %s"):format(p))
    end
    notify(("PR #%d: %d meaningful, %d auto-marked viewed\n%s"):format(
        pr.number, #result.meaningful, marked, table.concat(lines, "\n")))
    if cb then cb(result) end
end

function M.review()
    M.triage(function() vim.cmd("Octo review start") end)
end

-- Open difftastic output for the current file against the PR's merge-base
function M.difft_current()
    if vim.fn.executable("difft") == 0 then
        return notify("difft not found on PATH", vim.log.levels.ERROR)
    end
    local pr = pr_info()
    local upstream = pr and ("origin/" .. pr.baseRefName) or "origin/HEAD"
    local file = vim.fn.expand("%:.")
    local cmd = ("DFT_COLOR=always GIT_EXTERNAL_DIFF=difft git diff --ext-diff %s...HEAD -- %s | less -R")
        :format(vim.fn.shellescape(upstream), vim.fn.shellescape(file))
    vim.cmd("FloatermNew --autoclose=0 --width=0.95 --height=0.9 " .. cmd)
end

function M.setup()
    vim.api.nvim_create_user_command("PRTriage", function() M.triage() end,
        { desc = "Auto-mark cosmetic/noisy PR files as viewed" })
    vim.api.nvim_create_user_command("PRReview", M.review,
        { desc = "PRTriage, then start an Octo review" })
    vim.api.nvim_create_user_command("PRDifft", M.difft_current,
        { desc = "difftastic for current file vs PR base" })
end

return M

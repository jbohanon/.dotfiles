require("octo").setup({
    picker = "telescope",
    enable_builtin = true,
    use_local_fs = true,
    mappings = {
        review_diff = { toggle_viewed = { lhs = "<Leader>vv", desc = "toggle viewed" } },
        file_panel = { toggle_viewed = { lhs = "<Leader>vv", desc = "toggle viewed" } },
    },
    reviews = { auto_show_threads = true, focus = "right" },
})

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = require("gitsigns")
        local m = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        m("n", "]c", function()
            if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
        end, "Next hunk")
        m("n", "[c", function()
            if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
        end, "Prev hunk")

        m("n", "<Leader>hp", gs.preview_hunk, "Preview hunk")
        m("n", "<Leader>hs", gs.stage_hunk, "Stage hunk")
        m("n", "<Leader>hr", gs.reset_hunk, "Reset hunk")
        m("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        m("n", "<Leader>hw", gs.toggle_word_diff, "Toggle word diff")
        m("n", "<Leader>hd", gs.diffthis, "Diff against index")
        m("n", "<Leader>hD", function() gs.diffthis("~") end, "Diff against HEAD~")
    end,
})

require("diffview").setup({
    view = { merge_tool = { layout = "diff3_mixed" } },
})

local nmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

nmap("<Leader>op", "<cmd>Octo pr list<cr>", "Octo: PR list")
nmap("<Leader>os", "<cmd>Octo pr search<cr>", "Octo: PR search")
nmap("<Leader>oo", "<cmd>Octo pr checkout<cr>", "Octo: checkout PR")
nmap("<Leader>or", "<cmd>PRReview<cr>", "Octo: triage + review")
nmap("<Leader>ot", "<cmd>PRTriage<cr>", "Octo: triage only")
nmap("<Leader>oR", "<cmd>Octo review resume<cr>", "Octo: resume review")
nmap("<Leader>od", "<cmd>PRDifft<cr>", "difftastic: current file vs PR base")

nmap("<Leader>gd", "<cmd>DiffviewOpen<cr>", "Diffview: working tree")
nmap("<Leader>gh", "<cmd>DiffviewFileHistory %<cr>", "Diffview: file history")
nmap("<Leader>gq", "<cmd>DiffviewClose<cr>", "Diffview: close")

require("review").setup()

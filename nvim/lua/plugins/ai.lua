local map = vim.api.nvim_set_keymap

local noremap = function(ctx, keys, cmd, opts)
    opts = opts or {}
    opts['noremap'] = true
    opts['silent'] = true
    map(ctx, keys, cmd, opts)
end

local inoremap = function(keys, cmd)
    noremap('i', keys, cmd, nil)
end
local nnoremap = function(keys, cmd)
    noremap('n', keys, cmd, nil)
end
local vnoremap = function(keys, cmd)
    noremap('v', keys, cmd, nil)
end

nnoremap('<Leader>ai', ':AI<CR>')
nnoremap('<Leader>ch', ':AIChat /right<CR>:set wrap!<CR>i')
nnoremap('<Leader>s', ':AIChat<CR>')
-- " :AI
-- " - prompt: optional prepended prompt
-- " - engine: chat | complete - see how to configure complete engine in the section below
-- " - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
-- " - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
-- " - options.request_timeout: request timeout in seconds
-- " - options.enable_auth: enable authorization using openai key
-- " - options.token_file_path: override global token configuration
-- " - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
-- " - ui.paste_mode: use paste mode (see more info in the Notes below)
vim.g.vim_ai_complete = {
prompt = "",
  engine = "chat",
   options = {
    model = "gpt-3.5-turbo",
    endpoint_url = "https://ai.nonahob.net/proxy/v1/chat/completions",
    -- endpoint_url= "http://localhost:9000/v1/chat/completions",
    max_tokens = 0,
    max_completion_tokens = 0,
    temperature = 0.1,
    -- this timeout will be limited by an intermediate proxy if one exists.
    request_timeout = 60,
    stream = 1,
    enable_auth = 0,
    token_file_path = "",
    selection_boundary = "#####",
    initial_prompt = "",
   },
   ui = {
    paste_mode = 1,
   },
 }

-- " :AIEdit
-- " - prompt: optional prepended prompt
-- " - engine: chat | complete - see how to configure complete engine in the section below
-- " - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
-- " - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
-- " - options.request_timeout: request timeout in seconds
-- " - options.enable_auth: enable authorization using openai key
-- " - options.token_file_path: override global token configuration
-- " - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
-- " - ui.paste_mode: use paste mode (see more info in the Notes below)
vim.g.vim_ai_edit = {
prompt = "",
engine = "chat",
   options = {
    model = "gpt-4o",
    -- endpoint_url= "http://localhost:9000/v1/chat/completions",
    endpoint_url= "https://ai.nonahob.net/proxy/v1/chat/completions",
    max_tokens = 0,
    max_completion_tokens = 0,
    temperature = 0.1,
    -- this timeout will be limited by an intermediate proxy if one exists.
    request_timeout = 60,
    stream = 1,
    enable_auth = 0,
    token_file_path = "",
    selection_boundary = "#####",
    initial_prompt = "",
   },
   ui = {
    paste_mode = 1,
   },
 }

-- " This prompt instructs model to work with syntax highlighting
local initial_chat_prompt = [[
>>> system

 You are a general assistant. You are knowledgeable about lots of things, but especially about programming.
 If and only if you attach a code block with markdown syntax, add syntax type after ``` to enable syntax highlighting. Do not add ``` if you don't attach a code block.
 END
]]

-- " :AIChat
-- " - prompt: optional prepended prompt
-- " - options: openai config (see https://platform.openai.com/docs/api-reference/chat)
-- " - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
-- " - options.request_timeout: request timeout in seconds
-- " - options.enable_auth: enable authorization using openai key
-- " - options.token_file_path: override global token configuration
-- " - options.selection_boundary: selection prompt wrapper (eliminates empty responses, see #20)
-- " - ui.open_chat_command: preset (preset_below, preset_tab, preset_right) or a custom command
-- " - ui.populate_options: put [chat-options] to the chat header
-- " - ui.scratch_buffer_keep_open: re-use scratch buffer within the vim session
-- " - ui.force_new_chat: force new chat window (used in chat opening roles e.g. `/tab`)
-- " - ui.paste_mode: use paste mode (see more info in the Notes below)
vim.g.vim_ai_chat = {
-- \  "prompt": "",
   options= {
    model = "gpt-4o",
    endpoint_url= "https://ai.nonahob.net/proxy/v1/chat/completions",
    -- endpoint_url= "http://localhost:9000/v1/chat/completions",
    max_tokens = 0,
    max_completion_tokens = 0,
    temperature = 1,
    -- this timeout will be limited by an intermediate proxy if one exists.
    request_timeout = 60,
    stream = 1,
    enable_auth = 0,
    token_file_path = "",
    selection_boundary = "",
    initial_prompt = initial_chat_prompt,
   },
   ui = {
    open_chat_command = "preset_below",
    scratch_buffer_keep_open = 0,
    populate_options = 0,
    code_syntax_enabled = 1,
    force_new_chat = 0,
    paste_mode = 1,
   },
 }

-- ----------------------------------
-- AIImage is not currently supported
-- ----------------------------------
-- " :AIImage
-- " - prompt: optional prepended prompt
-- " - options: openai config (https://platform.openai.com/docs/api-reference/images/create)
-- " - options.request_timeout: request timeout in seconds
-- " - options.enable_auth: enable authorization using openai key
-- " - options.token_file_path: override global token configuration
-- " - options.download_dir: path to image download directory, `cwd` if not defined
-- vim.g.vim_ai_image = {
-- -- \  "prompt": "",
--    options= {
-- -- \    "model": "dall-e-3",
--      endpoint_url= "https://ai.nonahob.net/proxy/images/generations",
-- -- \    "quality": "standard",
-- -- \    "size": "1024x1024",
-- -- \    "style": "vivid",
-- -- \    "request_timeout": 20,
--      enable_auth= 0,
-- -- \    "token_file_path": "",
--    },
-- -- \  "ui": {
-- -- \    "download_dir": "",
-- -- \  },
--  }

-- custom roles file location
vim.g.vim_ai_roles_config_file = "/home/jacob/.dotfiles/nvim/lua/plugins/ai-roles.ini"

-- " custom token file location
-- let g:vim_ai_token_file_path = "~/.config/openai.token"

-- " debug settings
-- let g:vim_ai_debug = 0
-- let g:vim_ai_debug_log_file = "/tmp/vim_ai_debug.log"

-- " Notes:
-- " ui.paste_mode
-- " - if disabled code indentation will work but AI doesn't always respond with a code block
-- "   therefore it could be messed up
-- " - find out more in vim's help `:help paste`
-- " options.max_tokens
-- " - note that prompt + max_tokens must be less than model's token limit, see #42, #46
-- " - setting max tokens to 0 will exclude it from the OpenAI API request parameters, it is
-- "   unclear/undocumented what it exactly does, but it seems to resolve issues when the model
-- "   hits token limit, which respond with `OpenAI: HTTPError 400`

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "darkplus"

-- vim options
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.clipboard = "unnamedplus"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- hop shortcuts:
vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('n', 'l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('n', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})
lvim.builtin.which_key.mappings["a"] = { "<cmd>HopWord<cr>", "Hop to word" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>HopPattern<cr>", "Hop to pattern" }
--
lvim.builtin.which_key.mappings["gg"] = {"<cmd>LazyGit<CR>", "LazyGit"}
lvim.builtin.which_key.mappings["o"] = {"<cmd>RnvimrToggle<cr>", "File manager"}

vim.g.vim_matchtag_enable_by_default = 1
vim.g.vim_matchtag_files = '*.html,*.xml,*.js,*.jsx,*.vue,*.svelte,*.jsp,*.tpl'

require('luasnip.loaders.from_vscode').load({ paths = { "/home/brenoperes/.config/lvim/snippets" }})

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "perl",
  "scss",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
-- Emmet everywhere (hopefuly)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local emmet_options = {
  cmd = { vim.fn.stdpath "data" .. "/lsp_servers/emmet_ls/node_modules/.bin/emmet-ls", "--stdio" },
  capabilities = capabilities,
  filetypes = {
    "html",
    "smarty",
    "typescript",
    "javascript",
    "javascriptreact",
    "xml",
    "css",
    "scss",
    "perl"
  },
  root_dir = function ()
    return vim.loop.cwd()
  end
}
require("lvim.lsp.manager").setup("emmet_ls", emmet_options)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
vim.tbl_map(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  -- VSCode theme
  { "martinsione/darkplus.nvim" },

  -- Neovim motions on speed!
  {
    "phaazon/hop.nvim",
    branch = "v1"
  },

  -- Auto upload files to remote on save
  { "walialu/AutoRemoteSync.nvim" },

  -- Better jump to line
  { "nacro90/numb.nvim" },

  -- Colered parentheses like VSCode
  { "p00f/nvim-ts-rainbow" },

  -- Hint for function signatures when you type
  { "ray-x/lsp_signature.nvim" },

  -- Preview markdown on neovim (requires Glow binary)
  { "ellisonleao/glow.nvim" },

  -- Show indentation lines like VSCode
  { "lukas-reineke/indent-blankline.nvim" },

  -- Highlight TODOs
  { "folke/todo-comments.nvim" },

  -- Mappings to delete, change and add surroundings
  { "tpope/vim-surround" },

  -- Inline git blame
  { "f-person/git-blame.nvim" },

  -- Calls lazygit from Neovim (requires lazygit binary)
  { "kdheepak/lazygit.nvim" },

  -- Highlights matching html tags
  { "leafOfTree/vim-matchtag" },

  -- Minimap (requires code-minimap binary which can be installed with cargo )
  { "wfxr/minimap.vim" },

  -- Color highlighter
  { "norcalli/nvim-colorizer.lua" },

  { "ethanholz/nvim-lastplace" },

  -- Uses ranger inside neovim (obviously requires ranger)
  { "kevinhwang91/rnvimr" }
}

-- Plugin configuration
require 'hop'.setup {
  keys = 'tnplvmsefucriwyxaoqz',
  multi_windows = true
}
require 'numb'.setup {}
require 'nvim-treesitter.configs'.setup{
  highlight = {

  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  }
}
require 'lsp_signature'.setup {}
require 'indent_blankline'.setup {
  show_current_context = true,
  show_current_context_start = true
}
require 'todo-comments'.setup {}
-- Minimap settings
vim.cmd ("let g:minimap_width = 10")
vim.cmd ("let g:minimap_auto_start = 1")
vim.cmd ("let g:minimap_auto_start_win_enter = 1")
vim.cmd ("let g:minimap_git_colors = 1")
vim.cmd ("let g:minimap_highlight_range = 1")
vim.cmd ("let g:minimap_highlight_search = 1")
vim.cmd ("let g:minimap_close_buftypes = ['nofile', 'nowrite', 'terminal', 'prompt']")
require 'colorizer'.setup {}

-- }
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
local create_augroups = function(definitions)
  for group_name, definition in pairs(definitions) do
    local id = vim.api.nvim_create_augroup(group_name, {})

    for _, def in pairs(definition) do
      local event = def[1]
      local opts = def[2]
      opts.group = id

      vim.api.nvim_create_autocmd(event, opts)
    end
  end
end

local autocmds = {
  general = {
    { { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
      pattern = "*.*",
      command = "set nornu"
    } },
    { { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
      pattern = "*.*",
      command = "set rnu"
    } }
  }
}
create_augroups(autocmds)

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- require "user.user_plugins"

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "tokyonight-night"

vim.opt.showmode = true -- we don't need to see things like -- INSERT -- anymore
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.spell = false

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
local opts = { noremap = true, silent = true }
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
  i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
    ["<C-q>"] = actions.smart_send_to_qflist,
    ["<M-q>"] = actions.smart_add_to_qflist,
  },
--   -- for normal mode
  n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
    ["<C-q>"] = actions.smart_send_to_qflist,
    ["<M-q>"] = actions.smart_add_to_qflist,
  },
}

-- Quickfix and Location lists
-- keymap("n", "<C-q>", ":lua ToggleQFList()<CR>")
-- keymap("n", "<leader>qc", ":cexpr[]<CR>")
-- keymap("n", "<M-l>", ":lua ToggleLocList()<CR>")
-- keymap("n", "<leader>lc", ":lexpr[]<CR>")

-- Navigating items in the quickfix list
vim.keymap.set("n", "<M-j>", ":cnext<CR>", opts)
vim.keymap.set("n", "<M-k>", ":cprev<CR>", opts)
vim.keymap.set("n", "<leader>qc", ":cexpr[]<CR>", opts)

-- Navigating items in the location list
vim.keymap.set("n", "<leader>k", ":lprev<CR>", opts)
vim.keymap.set("n", "<leader>j", ":lnext<CR>", opts)
vim.keymap.set("n", "<leader>lc", ":lexpr[]<CR>", opts)

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "symbols")
  pcall(telescope.load_extension, "bibtex")
  pcall(telescope.load_extension, "github")
  pcall(telescope.load_extension, "vimwiki")
  pcall(telescope.load_extension, "projects")
  pcall(telescope.load_extension, "live_grep_args")
  -- any other extensions loading
end

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- Add a new binding to an existing WhichKey prefix by inserting into the appropriate table
local whichkey_search = lvim.builtin.which_key.mappings["s"]
table.insert(whichkey_search, {w = { "<cmd>pwd<cr>", "Current Directory" }})
table.insert(whichkey_search, {s = { ":lua require('telescope.builtin').grep_string()<CR>", "Search word under cursor" }})

local whichkey_buf = lvim.builtin.which_key.mappings["b"]
-- local fuzzy_buf_opt = require('telescope.themes').get_dropdown({height=10, previewer=true})
table.insert(whichkey_buf, {s = { ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Search in current buffer" }})

-- keymap("n", "<Leader>f", ":lua require('telescope.builtin').find_files()<CR>", opts)
-- keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
-- keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", opts)
-- keymap("n", "<leader>fs", ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", opts)
-- keymap("n", "<leader>fw", ":lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>", opts)
-- keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", opts)
-- keymap("n", "<leader>fe", ":lua require('telescope.builtin').file_browser({cwd = vim.fn.expand('%:p:h')})<CR>", opts)

-- keymap("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
-- keymap("n", "<leader>gwc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)


-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "fortran",
  "json",
  "lua",
  "python",
  "rust",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

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
-- require('lvim/user_plugins')
lvim.plugins = {
    {
        -- git diff in a single tabpage
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        -- Vim plugin to diff two directories
        "will133/vim-dirdiff",
    },
    -- {
    --     -- Show git blame
    --     "f-person/git-blame.nvim",
    --     event = "BufRead",
    --     config = function()
    --         vim.cmd "highlight default link gitblame SpecialComment"
    --         vim.g.gitblame_enabled = 0
    --     end,
    -- },
    {
        -- edit and review GitHub issues and pull requests
        "pwntester/octo.nvim",
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require("octo").setup()
        end,
    },
    {
        -- Git wrapper (in vimscript) from the Pontiff 
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Git",
            "Gdiffsplit",
            "Gvdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GDelete",
            "GBrowse",
            "GRemove",
            "GRename",
            "Glgrep",
            "Gedit"
        },
        ft = {"fugitive"},
    },
    {
        -- magit for neovim
        "TimUntersberger/neogit",
        requires = 'nvim-lua/plenary.nvim',
    },
    -- {
    --     -- Improved terminal navigation by The Primeagen
    --     "ThePrimeagen/harpoon.git",
    -- },
    {
        -- Working with git-worktree
        "ThePrimeagen/git-worktree.nvim",
    },
    -- {
    --     -- fzy style sorter that is compiled
    --     "nvim-telescope/telescope-fzy-native.nvim",
    --     run = "make",
    --     event = "BufRead",
    -- },
    {
        "nvim-telescope/telescope-symbols.nvim",
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    {
        "nvim-telescope/telescope-bibtex.nvim",
    },
    {
        "nvim-telescope/telescope-github.nvim",
    },
    {
        "ElPiloto/telescope-vimwiki.nvim",
    },
    {
        -- switch between projects
        "nvim-telescope/telescope-project.nvim",
        event = "BufWinEnter",
        setup = function()
            vim.cmd [[packadd telescope.nvim]]
        end,
    },
    {
        "folke/lsp-colors.nvim",
        event = "BufRead",
    },
    {
        "rmagatti/goto-preview",
        config = function()
        require('goto-preview').setup {
              width = 120; -- Width of the floating window
              height = 25; -- Height of the floating window
              default_mappings = false; -- Bind default mappings
              debug = false; -- Print debug information
              opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
              post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
              -- You can use "default_mappings = true" setup option
              -- Or explicitly set keybindings
              -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
              -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
              -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
            }
        end,
    },
    -- { -- Deprecated
    --     "ahmedkhalf/lsp-rooter.nvim",
    --     event = "BufRead",
    --     config = function()
    --         require("lsp-rooter").setup()
    --     end,
    -- },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require"lsp_signature".on_attach()
        end,
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require('symbols-outline').setup {
                symbol_blacklist = {
                    -- 'File',
                    -- 'Module',
                    -- 'Namespace',
                    -- 'Package',
                    -- 'Class',
                    -- 'Method',
                    'Property',
                    'Field',
                    -- 'Constructor',
                    'Enum',
                    -- 'Interface',
                    -- 'Function',
                    'Variable',
                    'Constant',
                    'String',
                    'Number',
                    'Boolean',
                    -- 'Array',
                    -- 'Object',
                    -- 'Key',
                    -- 'Null',
                    'EnumMember',
                    -- 'Struct',
                    -- 'Event',
                    -- 'Operator',
                    -- 'TypeParameter',
                    -- 'Component',
                    -- 'Fragment',
                }
            }
        end,
    },
    {
        -- Highlight, list and search todo comments in your projects
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
              -- keywords recognized as todo comments
              keywords = {
              --   FIX = {
              --     icon = " ", -- icon used for the sign, and in search results
              --     color = "error", -- can be a hex color, or a named color (see below)
              --     alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
              --     -- signs = false, -- configure signs for some keywords individually
              --   },
              --   TODO = { icon = " ", color = "info" },
              --   HACK = { icon = " ", color = "warning" },
              --   WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
              --   PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
              --   NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                DEBUG = { icon = " ", color = "warning", alt = { "DEBUGGPC","DEBUG_GPC","DEBUG-GPC","DEBUG GPC" } },
                ACTION = { icon = " ", color = "hint", alt = { "ACTION","Action" } },
                ACTION_DONE = { icon = " ", color = "info", alt = { "ACTION DONE","Action Done" } },
              },
              -- merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            }
        end
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "vimwiki/vimwiki",
        opt = false,
    },
    {
        "tpope/vim-markdown",
    },
    {
        "AckslD/nvim-neoclip.lua",
        requires = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('neoclip').setup()
        end,
    }
}

vim.cmd("let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]")

-- local telescope_opts = { noremap = true, silent = true }
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
-- vim.keymap.set("n", "<leader>vw", ":lua require('telescope').extensions.vimwiki.vimwiki()<CR>", telescope_opts)
-- vim.keymap.set("n", "<leader>vg", ":lua require('telescope').extensions.vw.live_grep()<CR>", telescope_opts)
-- vim.keymap.set("n", "<leader>vp", ":!qmarkdown -d % &<CR>", telescope_opts)
-- vim.keymap.set("n", "<leader>vd", ":lua vim.cmd(\"put =strftime('%A %d %B, %Y, %H:%Mh %z')\")<CR>", telescope_opts)

lvim.keys.normal_mode["<leader>vw"] = ":lua require('telescope').extensions.vimwiki.vimwiki()<CR>"
lvim.keys.normal_mode["<leader>vg"] = ":lua require('telescope').extensions.vw.live_grep()<CR>"
lvim.keys.normal_mode["<leader>vp"] = ":!qmarkdown -d % &<CR>"
lvim.keys.normal_mode["<leader>vd"] = ":lua vim.cmd(\"put =strftime('%A %d %B, %Y, %H:%Mh %z')\")<CR>"

-- lvim.keys.normal_mode["da"] = ":lua print('Hello Joe using lvim!')<cr>"
-- lvim.keys.normal_mode["df"] = ":lua print('Hello Joe using nvim!')<cr>"
-- vim.keymap.set("n", "<leader>df", ":lua print('Hello Joe using nvim!')<cr>" )

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })


do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  vim.o.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true

  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })

	---@param repo string
	---@return string
	local function gh(repo) return 'https://github.com/' .. repo end
end

do
	require("config.lazy")
end

-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
--   -- [[ Installing and Configuring Plugins ]]
--   --
--   -- To install a plugin simply call `vim.pack.add` with its git url.
--   -- This will download the default branch of the plugin, which will usually be `main` or `master`
--   -- You can also have more advanced specs, which we will talk about later.
--   --
--   -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
--   --
--   -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
--   -- automatically detecting and setting the indentation.
--   --
--   -- We first install it from https://github.com/NMAC427/guess-indent.nvim
--   -- and then call its `setup()` function to start it with default settings.
--   vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
--   require('guess-indent').setup {}
--
--   -- Because lua is a real programming language, you can also have some logic to your installation -
--   -- like only installing a plugin if a condition is met.
--   --
--   -- Here we only install `nvim-web-devicons` (which adds pretty icons) if we have a Nerd Font,
--   -- since otherwise the icons won't display properly.
--   if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end
--
--   -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
--   --
--   -- See `:help gitsigns` to understand what each configuration key does.
--   -- Adds git related signs to the gutter, as well as utilities for managing changes
--   vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
--   require('gitsigns').setup {
--     signs = {
--       add = { text = '+' }, ---@diagnostic disable-line: missing-fields
--       change = { text = '~' }, ---@diagnostic disable-line: missing-fields
--       delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
--       topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
--       changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
--     },
--   }
--
--   -- -- Useful plugin to show you pending keybinds.
--   -- vim.pack.add { gh 'folke/which-key.nvim' }
--   -- require('which-key').setup {
--   --   -- Delay between pressing a key and opening which-key (milliseconds)
--   --   delay = 0,
--   --   icons = { mappings = vim.g.have_nerd_font },
--   --   -- Document existing key chains
--   --   spec = {
--   --     { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
--   --     { '<leader>t', group = '[T]oggle' },
--   --     { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
--   --     { 'gr', group = 'LSP Actions', mode = { 'n' } },
--   --   },
--   -- }
--
--   -- [[ Colorscheme ]]
--   -- You can easily change to a different colorscheme.
--   -- Change the name of the colorscheme plugin below, and then
--   -- change the command under that to load whatever the name of that colorscheme is.
--   --
--   -- -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
--   -- vim.pack.add { gh 'folke/tokyonight.nvim' }
--   -- ---@diagnostic disable-next-line: missing-fields
--   -- require('tokyonight').setup {
--   --   styles = {
--   --     comments = { italic = false }, -- Disable italics in comments
--   --   },
--   -- }
--   --
--   -- -- Load the colorscheme here.
--   -- -- Like many other themes, this one has different styles, and you could load
--   -- -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--   -- vim.cmd.colorscheme 'tokyonight-night'
--
--   vim.pack.add {
--     'https://github.com/ellisonleao/gruvbox.nvim',
--   }
--
--   -- Default options:
--   -- require("gruvbox").setup({
--   --   terminal_colors = true, -- add neovim terminal colors
--   --   undercurl = true,
--   --   underline = true,
--   --   bold = true,
--   --   italic = {
--   --     strings = true,
--   --     emphasis = true,
--   --     comments = true,
--   --     operators = false,
--   --     folds = true,
--   --   },
--   --   strikethrough = true,
--   --   invert_selection = false,
--   --   invert_signs = false,
--   --   invert_tabline = false,
--   --   inverse = true, -- invert background for search, diffs, statuslines and errors
--   --   contrast = "", -- can be "hard", "soft" or empty string
--   --   palette_overrides = {},
--   --   overrides = {},
--   --   dim_inactive = false,
--   --   transparent_mode = false,
--   -- })
--   -- vim.cmd("colorscheme gruvbox")
--
--   require('gruvbox').setup {
--     terminal_colors = true, -- add neovim terminal colors
--     undercurl = true,
--     underline = true,
--     bold = true,
--     italic = {
--       strings = true,
--       emphasis = true,
--       comments = true,
--       operators = false,
--       folds = true,
--     },
--     strikethrough = true,
--     invert_selection = false,
--     invert_signs = false,
--     invert_tabline = false,
--     inverse = true, -- invert background for search, diffs, statuslines and errors
--     contrast = '', -- can be "hard", "soft" or empty string
--     palette_overrides = {},
--     overrides = {},
--     dim_inactive = false,
--     transparent_mode = false,
--   }
--
--   vim.o.background = 'dark'
--   vim.cmd.colorscheme 'gruvbox'
--
--   -- Highlight todo, notes, etc in comments
--   vim.pack.add { gh 'folke/todo-comments.nvim' }
--   require('todo-comments').setup { signs = false }
--
--   -- [[ mini.nvim ]]
--   --  A collection of various small independent plugins/modules
--   vim.pack.add { gh 'nvim-mini/mini.nvim' }
--
--   -- Better Around/Inside textobjects
--   --
--   -- Examples:
--   --  - va)  - [V]isually select [A]round [)]paren
--   --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--   --  - ci'  - [C]hange [I]nside [']quote
--   require('mini.ai').setup {
--     -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
--     mappings = {
--       around_next = 'aa',
--       inside_next = 'ii',
--     },
--     n_lines = 500,
--   }
--
--   -- Add/delete/replace surroundings (brackets, quotes, etc.)
--   --
--   -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--   -- - sd'   - [S]urround [D]elete [']quotes
--   -- - sr)'  - [S]urround [R]eplace [)] [']
--   require('mini.surround').setup()
--
--   -- Simple and easy statusline.
--   --  You could remove this setup call if you don't like it,
--   --  and try some other statusline plugin
--   local statusline = require 'mini.statusline'
--   -- Set `use_icons` to true if you have a Nerd Font
--   statusline.setup { use_icons = vim.g.have_nerd_font }
--
--   -- You can configure sections in the statusline by overriding their
--   -- default behavior. For example, here we set the section for
--   -- cursor location to LINE:COLUMN
--   ---@diagnostic disable-next-line: duplicate-set-field
--   statusline.section_location = function() return '%2l:%-2v' end
--
--   -- ... and there is more!
--   --  Check out: https://github.com/nvim-mini/mini.nvim
end

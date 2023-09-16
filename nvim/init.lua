-- NEOVIM CONFIGURATION

-- BOOTSTRAP PLUGIN MANAGER
local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
if not is_installed then
	vim.fn.system({
		"git",
		"clone",
		"--depth=1",
		"https://github.com/savq/paq-nvim.git",
		path
	})
	vim.cmd.packadd("paq-nvim")
end


-- PLUGINS
require("paq") {
  -- plugin manager
	"savq/paq",
  -- colorscheme
  "sainnhe/gruvbox-material",
  -- editor
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end
  },
  "echasnovski/mini.comment",
  "echasnovski/mini.pairs",
  "echasnovski/mini.surround",
  -- search
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  },
  -- lsp
  -- ui
  "goolord/alpha-nvim",
  "nvim-lualine/lualine.nvim",
  "folke/which-key.nvim",
  "lewis6991/gitsigns.nvim",
  "christoomey/vim-tmux-navigator",
  -- lib
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
}


-- VIM OPTIONS 
vim.g.mapleader = ","
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 16
vim.opt.shortmess = "aS"
vim.opt.foldcolumn = "auto"
vim.opt.fillchars = "eob: "


-- COLORSCHEME
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.g.gruvbox_material_foreground = "original"
vim.cmd("colorscheme gruvbox-material")


-- PLUGIN CONFIGURATIONS
-- treesitter
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  auto_install = true,
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "query",
    "c",
    "regex",
    "bash",
    "fish",
  }
})

-- mini.comment
require("mini.comment").setup()

-- mini.pairs
require("mini.pairs").setup()

-- mini.surround
require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    replace = "cs"
  }
})

-- telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      file_ignore_patterns = { "^.git/", "%.lock" },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      initial_mode = "normal",
      hidden = true,
      grouped = true,
      respect_gitignore = false,
      path = "%:p:h",
    },
  }
})
telescope.load_extension("file_browser")
telescope.load_extension("fzf")

-- alpha-nvim
local dashboard = require("alpha.themes.dashboard")
dashboard.section.buttons.val = {
  dashboard.button( "e", "  > New file" , ":ene<CR>"),
  dashboard.button( "f", "󰈞  > Find files", ":Telescope find_files<CR>"),
  dashboard.button( "u", "  > Update plugins" , ":Paq sync"),
  dashboard.button( "q", "󰅚  > Quit", ":qa<CR>"),
}
local version = vim.version()
dashboard.section.footer.val = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
require("alpha").setup(dashboard.opts)

-- lualine
local custom_gruvbox = require("lualine.themes.gruvbox-material")
custom_gruvbox.normal.c.bg = "nil"
custom_gruvbox.insert.c.bg = "nil"
custom_gruvbox.visual.c.bg = "nil"
custom_gruvbox.replace.c.bg = "nil"
custom_gruvbox.command.c.bg = "nil"
custom_gruvbox.inactive.c.bg = "nil"
require("lualine").setup({
  options = {
    disabled_filetypes = {"help", "alpha"},
    theme = custom_gruvbox,
    icons_enabled = true,
    globalstatus = true,
    component_separators = "",
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {{
      "mode",
      separator = { left = '' },
      padding = { left = 1, right = 2 }
    }},
    lualine_b = {{
      "branch",
      padding = { left = 2, right = 1 },
      icons_enabled = true
    }},
    lualine_c = {"filename"},
    lualine_x = {"searchcount"},
    lualine_y = {{
      "filetype",
      colored = false,
      padding = { left = 1, right = 2 }
    }},
    lualine_z = {{
      "progress",
      separator = { left = "" },
      padding = { left = 2, right = 0 }
    }, {
      "location",
      separator = { right = '' },
      padding = { left = 1, right = 1 }
    }}
  }
})

-- which-key
vim.opt.timeout = true
vim.opt.timeoutlen = 300
require("which-key").setup()

-- gitsigns
require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 100
  }
})


-- KEYMAPS
vim.keymap.set("n", "<leader>S", ":so $MYVIMRC<CR>", { noremap = true, desc = "Source configuration" })
vim.keymap.set("n", "<C-A-l>", ":nohlsearch<CR>", { silent = true, desc = "Clear highlight" })

-- up/down 
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- resize 
vim.keymap.set("n", "<C-A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- lines
vim.keymap.set("n", "<C-A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("n", "<C-A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("i", "<C-A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("i", "<C-A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("v", "<C-A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("v", "<C-A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- paq
vim.keymap.set("n", "<leader>ps", "<cmd>PaqSync<CR>", { desc = "Paq sync" })
vim.keymap.set("n", "<leader>pc", "<cmd>PaqClean<CR>", { desc = "Paq clean" })
vim.keymap.set("n", "<leader>pi", "<cmd>PaqInstall<CR>", { desc = "Paq install" })
vim.keymap.set("n", "<leader>pu", "<cmd>PaqUpdate<CR>", { desc = "Paq update" })

-- telescope
vim.keymap.set("n", "<leader>fr", telescope_builtin.resume, { desc = "Resume Telescope", silent = true })
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files", silent = true })
vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files, { desc = "Find files (git)", silent = true })
vim.keymap.set("n", "<leader>fs", telescope_builtin.live_grep, { desc = "Live grep", silent = true })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers", silent = true })
vim.keymap.set( "n", "<leader>fd", telescope.extensions.file_browser.file_browser, { desc = "Open file browser", silent = true })

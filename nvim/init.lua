-- NEOVIM CONFIGURATION

-- BOOTSTRAPPING PLUGIN MANAGER
local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if vim.fn.empty(vim.fn.glob(path)) > 0 then
  vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path }
end

vim.cmd('packadd paq-nvim')

-- PLUGINS
require('paq') {
    -- init
    'savq/paq-nvim',
    -- support
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- theme
    'sainnhe/gruvbox-material',
    'nvim-tree/nvim-web-devicons',
    -- editor
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'windwp/nvim-autopairs',
    -- functionality
    'christoomey/vim-tmux-navigator',
    'rcarriga/nvim-notify',
    'folke/which-key.nvim',
    'folke/trouble.nvim',
    'folke/noice.nvim',
    'nvim-lualine/lualine.nvim',
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',
    'slim-template/vim-slim',
    { 'nvim-treesitter/nvim-treesitter', run = function() vim.cmd('TSUpdate') end },
    { 'nvim-telescope/telescope.nvim',   branch = '0.1.x' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    'nvim-telescope/telescope-file-browser.nvim',
    -- language
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
}

-- SETTINGS
-- options
vim.g.mapleader = ','
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 4

-- theme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.gruvbox_material_foreground = 'original'
vim.cmd('colorscheme gruvbox-material')
vim.cmd('highlight EndOfBuffer guifg=bg')

-- paq
vim.keymap.set('n', '<leader>ps', '<cmd>PaqSync<CR>', {desc = 'PaqSync'})
vim.keymap.set('n', '<leader>pc', '<cmd>PaqClean<CR>', {desc = 'PaqClean'})
vim.keymap.set('n', '<leader>pi', '<cmd>PaqInstall<CR>', {desc = 'PaqInstall'})
vim.keymap.set('n', '<leader>pu', '<cmd>PaqUpdate<CR>', {desc = 'PaqUpdate'})
vim.keymap.set('n', '<leader>pl', '<cmd>PaqList<CR>', {desc = 'PaqList'})

-- web-devicons
require('nvim-web-devicons').setup()

-- notify
require('notify').setup({
  timeout = 500,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
  stages = 'fade',
})

-- which-key
local wk = require('which-key')
wk.setup()

-- trouble
require('trouble').setup()
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true, desc = 'Toggle Trouble'}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true, desc = 'Trouble workspace diagnostics'}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true, desc = 'Trouble document diagnostics'}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true, desc = 'Trouble loclist'}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true, desc = 'Trouble quickfix'}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true, desc = 'Trouble references'}
)

-- noice
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
  },
})

-- treesitter
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'vim',
    'lua',
    'help',
    'regex',
    'javascript',
    'typescript',
    'tsx',
    'html',
    'css',
    'json',
    'ruby',
    'yaml',
    'bash',
    'fish',
    'markdown',
    'markdown_inline',
  },
})

-- lualine
local gruvbox = require('lualine.themes.gruvbox')
local configuration = vim.fn['gruvbox_material#get_configuration']()
local palette = vim.fn['gruvbox_material#get_palette'](configuration.background, configuration.foreground, configuration.colors_override)

local custom_gruvbox = {
    normal = {
        a = { bg = palette.grey2[1], fg = palette.bg0[1], gui = 'bold' },
        b = { bg = palette.bg_statusline3[1], fg = palette.grey2[1] },
        c = { bg = palette.bg0[1], fg = palette.fg0[1] },
        z = { bg = palette.grey2[1], fg = palette.bg0[1] },
    },
    insert = {
        a = { bg = palette.blue[1], fg = palette.bg0[1], gui = 'bold' },
        z = { bg = palette.blue[1], fg = palette.bg0[1] },
    },
    visual = {
        a = { bg = palette.orange[1], fg = palette.bg0[1], gui = 'bold' },
        z = { bg = palette.orange[1], fg = palette.bg0[1] },
    },
    replace = {
        a = { bg = palette.aqua[1], fg = palette.bg0[1], gui = 'bold' },
        z = { bg = palette.aqua[1], fg = palette.bg0[1] },
    },
    command = {
        a = { bg = palette.green[1], fg = palette.bg0[1], gui = 'bold' },
        z = { bg = palette.green[1], fg = palette.bg0[1] },
    },
    inactive = {
        a = { bg = palette.bg0[1], fg = palette.fg0[1]},
        b = { bg = palette.bg0[1], fg = palette.fg0[1]},
        c = { bg = palette.bg0[1], fg = palette.fg0[1]},
    },
}
require('lualine').setup({
  options = {
    theme = custom_gruvbox,
    component_separators = '|',
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = {{'mode', separator = { left = '' }, right_padding = 2 }},
    -- lualine_b = {'branch'},
    lualine_b = {
      'branch',
      {'filetype', icon_only = true, colored = false, separator = '', padding = {left = 1, right = 0}},
      {'filename', path = 1, newfile_status = true}
    },
    lualine_c = {},
    lualine_x = {
      {
        function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
      },
      {
        function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
      },
    },
    lualine_y = {
      { "progress" },
    },
    lualine_z = {
      { "location", separator = { right = '' }, left_padding = 2 },
    },
  },
})

-- gitsigns
require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 100,
    },
})

-- telescope
local telescope = require('telescope')
telescope.setup({
  defaults = {},
  pickers = {
    lsp_definitions = { initial_mode = 'normal' },
    lsp_type_definitions = { initial_mode = 'normal' },
    lsp_references = { initial_mode = 'normal' },
    lsp_implementations = { initial_mode = 'normal' },
    find_files = {
      hidden = true,
      file_ignore_patterns = { ".git/.*" },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      initial_mode = 'normal',
      hidden = true,
      grouped = true,
    },
  },
})
telescope.load_extension('file_browser')
telescope.load_extension('fzf')
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {desc = 'Find files', silent = true})
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, {desc = 'Find files (git)', silent = true})
vim.keymap.set('n', '<leader>fs', telescope_builtin.live_grep, {desc = 'Live grep', silent = true})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {desc = 'Find buffers', silent = true})
vim.keymap.set('n', '<leader>fd', telescope.extensions.file_browser.file_browser, {desc = 'Open file browser', silent = true})

-- autopairs
require('nvim-autopairs').setup()

-- LSP
-- vim diagnostic
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})

-- mason
require('mason').setup()
require('mason-lspconfig').setup()
vim.keymap.set('n', '<leader>M', ':Mason', {desc = 'Open Mason'})

-- cmp
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.setup({
    snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- lspconfig
local on_attach = function(_, bufnr)
  local lsp_opts = function(t)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    for k, v in pairs(t) do
      bufopts[k] = v
    end
    return bufopts
  end
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_opts({desc = 'Declaration'}))
  vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', lsp_opts({desc = 'Definition'}))
  vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', lsp_opts({desc = 'Type definition'}))
  vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', lsp_opts({desc = 'Implementation'}))
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', lsp_opts({desc = 'References'}))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, lsp_opts({desc = 'Hover'}))
  vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, lsp_opts({desc = 'Signature help'}))
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, lsp_opts({desc = 'Rename'}))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, lsp_opts({desc = 'Code action'}))
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['lua_ls'].setup({ on_attach = on_attach, capabilities = capabilities })
require('lspconfig')['html'].setup({ on_attach = on_attach, capabilities = capabilities })
require('lspconfig')['cssls'].setup({ on_attach = on_attach, capabilities = capabilities })
require('lspconfig')['tsserver'].setup({ on_attach = on_attach, capabilities = capabilities })
require('lspconfig')['jsonls'].setup({ on_attach = on_attach, capabilities = capabilities })
require('lspconfig')['tailwindcss'].setup({ on_attach = on_attach, capabilities = capabilities })

-- KEYMAPS
vim.keymap.set('n', '<leader>S', ':so $MYVIMRC<CR>', { noremap = true, desc = 'Re-source config' })
vim.keymap.set("n", "<C-A-l>", ":nohlsearch<CR>", { silent = true, desc = "Clear highlight" })

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
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

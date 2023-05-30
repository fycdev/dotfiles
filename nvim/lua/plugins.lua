return {
  -- COLORSCHEME
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.g.gruvbox_material_foreground = "original"
      vim.cmd("colorscheme gruvbox-material")
      vim.cmd("highlight EndOfBuffer guifg=bg")
    end,
  },
  -- LIB
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  -- SEARCH
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
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
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local telescope_builtin = require("telescope.builtin")

      telescope.setup(opts)
      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")

      vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files", silent = true })
      vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files, { desc = "Find files (git)", silent = true })
      vim.keymap.set("n", "<leader>fs", telescope_builtin.live_grep, { desc = "Live grep", silent = true })
      vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers", silent = true })
      vim.keymap.set(
        "n",
        "<leader>fd",
        telescope.extensions.file_browser.file_browser,
        { desc = "Open file browser", silent = true }
      )
    end,
  },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
  -- CODING
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      highlight = {
        enable = true,
      },
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "query",
        "c",
        "regex",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "ruby",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "fish",
      },
    },
  },
  {
    "slim-template/vim-slim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "tpope/vim-commentary",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "windwp/nvim-autopairs",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = "L",
              vsnip = "V",
              buffer = "B",
              path = "P",
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }),
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "tsserver",
        "emmet_ls",
        "tailwindcss",
        "eslint",
        "jsonls",
        "solargraph",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "standardrb",
      },
      automatic_installation = false,
      handlers = {},
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Actions",
        callback = function()
          local lsp_opts = function(t)
            local bufopts = { noremap = true, silent = true, buffer = true }
            for k, v in pairs(t) do
              bufopts[k] = v
            end
            return bufopts
          end
          vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts({ desc = "Hover information" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_opts({ desc = "Definition" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts({ desc = "Declaration" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, lsp_opts({ desc = "Implementation" }))
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, lsp_opts({ desc = "Type definitions" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, lsp_opts({ desc = "References" }))
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, lsp_opts({ desc = "Signature help" }))
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, lsp_opts({ desc = "Rename" }))
          vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, lsp_opts({ desc = "Code Action" }))
          vim.keymap.set("x", "<F4>", vim.lsp.buf.range_code_action, lsp_opts({ desc = "Code Action" }))
          vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, lsp_opts({ desc = "Format" }))
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, lsp_opts({ desc = "Open diagnostics" }))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, lsp_opts({ desc = "Next diagnostic" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, lsp_opts({ desc = "Previos diagnostic" }))
        end,
      })

      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities =
          vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("lspconfig")["lua_ls"].setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim",
                "require",
              },
            },
          },
        },
      })
      require("lspconfig")["html"].setup({})
      require("lspconfig")["cssls"].setup({})
      require("lspconfig")["tsserver"].setup({})
      require("lspconfig")["jsonls"].setup({})
      require("lspconfig")["tailwindcss"].setup({})
      require("lspconfig")["solargraph"].setup({})
      require("lspconfig")["eslint"].setup({})
      require("lspconfig")["emmet_ls"].setup({})
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-null-ls.nvim",
      "lewis6991/gitsigns.nvim",
    },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.code_actions.gitsigns,
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      icons = false
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      vim.keymap.set(
        "n",
        "<leader>xx",
        "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true, desc = "Toggle Trouble" }
      )
      vim.keymap.set(
        "n",
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Trouble workspace diagnostics" }
      )
      vim.keymap.set(
        "n",
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true, desc = "Trouble document diagnostics" }
      )
    end,
  },
  -- GIT
  { "tpope/vim-fugitive", event = "VeryLazy" },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "tpope/vim-fugitive" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100,
      },
    },
  },
  -- UTILITIES
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },
}

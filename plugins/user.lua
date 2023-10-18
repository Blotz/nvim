local utils = require "astronvim.utils"

return {
  -- project
  {
    "jay-babu/project.nvim",
    main = "project_nvim",
    event = "VeryLazy",
    opts = { ignore_lsp = { "lua_ls" } },
    keys = {
      {
        "<leader>Sp",
        "<cmd>:Telescope projects<cr>",
        desc = "Find project files",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = { "jay-babu/project.nvim" },
    opts = function() require("telescope").load_extension "projects" end,
  },
  -- git
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
  },
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = { suggestion = { auto_trigger = true, debounce = 150 } },
  },
  -- neodim
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    opts = {
      alpha = 0.75,
      blend_color = "#000000",
      update_in_insert = {
        enable = true,
        delay = 100,
      },
      hide = {
        virtual_text = true,
        signs = true,
        underline = true,
      },
    },
  },
  -- comments
  {
    "folke/todo-comments.nvim",
    opts = {},
    event = "User AstroFile",
  },
  -- vim-move
  -- {
  --   "matze/vim-move",
  --   event = "BufEnter",
  -- },
  -- clickable links
  {
    "sontungexpt/url-open",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then return end
      url_open.setup {}
    end,
    keys = {
      { "<C-LeftMouse>", "<cmd>URLOpenUnderCursor<cr>", desc = "Open URL under cursor" },
    },
  },

  -- python
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python", -- NOTE: ft: lazy-load on filetype
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      require("dap-python").setup(path, opts)
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" },
      { "<leader>lc", "<cmd>:VenvSelectCached<cr>", desc = "Retrieve the VirtualEnv from Cache" },
    },
  },

  -- haskell
  -- {
  --   "mrcjkb/haskell-tools.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     { "nvim-telescope/telescope.nvim", optional = true },
  --     { "mfussenegger/nvim-dap", optional = true },
  --   },
  --   version = "^2",
  --   -- load the plugin when opening one of the following file types
  --   ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  --   init = function()
  --     astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "hls")
  --     vim.g.haskell_tools = vim.tbl_deep_extend("keep", vim.g.haskell_tools or {}, {
  --       hls = {
  --         on_attach = function(client, bufnr, _) require("astronvim.utils.lsp").on_attach(client, bufnr) end,
  --       },
  --     })
  --   end,
  -- },

  -- Latex
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- add which-key mapping descriptions for VimTex
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Set up VimTex Which-Key descriptions",
        group = vim.api.nvim_create_augroup("vimtex_mapping_descriptions", { clear = true }),
        pattern = "tex",
        callback = function(event)
          local wk = require "which-key"
          local opts = {
            mode = "n", -- NORMAL mode
            buffer = event.buf, -- Specify a buffer number for buffer local mappings to show only in tex buffers
          }
          local mappings = {
            ["<localleader>l"] = {
              name = "+VimTeX",
              a = "Show Context Menu",
              C = "Full Clean",
              c = "Clean",
              e = "Show Errors",
              G = "Show Status for All",
              g = "Show Status",
              i = "Show Info",
              I = "Show Full Info",
              k = "Stop VimTeX",
              K = "Stop All VimTeX",
              L = "Compile Selection",
              l = "Compile",
              m = "Show Imaps",
              o = "Show Compiler Output",
              q = "Show VimTeX Log",
              s = "Toggle Main",
              t = "Open Table of Contents",
              T = "Toggle Table of Contents",
              v = "View Compiled Document",
              X = "Reload VimTeX State",
              x = "Reload VimTeX",
            },
            ["ts"] = {
              name = "VimTeX Toggles & Cycles", -- optional group name
              ["$"] = "Cycle inline, display & numbered equation",
              c = "Toggle star of command",
              d = "Cycle (), \\left(\\right) [,...]",
              D = "Reverse Cycle (), \\left(\\right) [, ...]",
              e = "Toggle star of environment",
              f = "Toggle a/b vs \\frac{a}{b}",
            },
            ["[/"] = "Previous start of a LaTeX comment",
            ["[*"] = "Previous end of a LaTeX comment",
            ["[["] = "Previous beginning of a section",
            ["[]"] = "Previous end of a section",
            ["[m"] = "Previous \\begin",
            ["[M"] = "Previous \\end",
            ["[n"] = "Previous start of a math zone",
            ["[N"] = "Previous end of a math zone",
            ["[r"] = "Previous \\begin{frame}",
            ["[R"] = "Previous \\end{frame}",
            ["]/"] = "Next start of a LaTeX comment %",
            ["]*"] = "Next end of a LaTeX comment %",
            ["]["] = "Next beginning of a section",
            ["]]"] = "Next end of a section",
            ["]m"] = "Next \\begin",
            ["]M"] = "Next \\end",
            ["]n"] = "Next start of a math zone",
            ["]N"] = "Next end of a math zone",
            ["]r"] = "Next \\begin{frame}",
            ["]R"] = "Next \\end{frame}",
            ["cs"] = {
              c = "Change surrounding command",
              e = "Change surrounding environment",
              ["$"] = "Change surrounding math zone",
              d = "Change surrounding delimiter",
            },
            ["ds"] = {
              c = "Delete surrounding command",
              e = "Delete surrounding environment",
              ["$"] = "Delete surrounding math zone",
              d = "Delete surrounding delimiter",
            },
          }
          wk.register(mappings, opts)
          -- VimTeX Text Objects without variants with targets.vim
          opts = {
            mode = "o", -- Operator pending mode
            buffer = event.buf,
          }
          local objects = {
            ["ic"] = [[LaTeX Command]],
            ["ac"] = [[LaTeX Command]],
            ["id"] = [[LaTeX Math Delimiter]],
            ["ad"] = [[LaTeX Math Delimiter]],
            ["ie"] = [[LaTeX Environment]],
            ["ae"] = [[LaTeX Environment]],
            ["i$"] = [[LaTeX Math Zone]],
            ["a$"] = [[LaTeX Math Zone]],
            ["iP"] = [[LaTeX Section, Paragraph, ...]],
            ["aP"] = [[LaTeX Section, Paragraph, ...]],
            ["im"] = [[LaTeX Item]],
            ["am"] = [[LaTeX Item]],
          }
          wk.register(objects, opts)
        end,
      })
    end,
  },
}

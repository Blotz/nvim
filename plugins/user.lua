return {
  -- project
  {
    "jay-babu/project.nvim",
    main = "project_nvim",
    event = "VeryLazy",
    opts = { ignore_lsp = { "lua_ls" } },
    keys = {
      -- mappings seen under group name "Session"
      ["<leader>Sp"] = {
        function() require("telescope").extensions.projects.projects() end,
        desc = "Pick project",
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
  -- {
  --   "chrisgrieser/nvim-tinygit",
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "rcarriga/nvim-notify", -- optional, for nice notifications
  --   },
  -- },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = { suggestion = { auto_trigger = true, debounce = 150 } },
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

  -- compiler (unsure if this will work)
  {
    "Zeioth/compiler.nvim",
    dependencies = {
      {
        "stevearc/overseer.nvim",
        opts = {
          task_list = { -- this refers to the window that shows the result
            direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
            bindings = {
              ["q"] = function() vim.cmd "OverseerClose" end,
            },
          },
        },
        config = function(_, opts) require("overseer").setup(opts) end,
      },
    },
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    opts = {},
  },

  -- lazy.nvim
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
}

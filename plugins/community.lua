return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.fluormachine-nvim" },
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },

  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.rust" },
}

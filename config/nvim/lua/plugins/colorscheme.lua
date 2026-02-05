return {
  -- add github-nvim-theme
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },

  -- Configure LazyVim to load github_dark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark",
    },
  },
}

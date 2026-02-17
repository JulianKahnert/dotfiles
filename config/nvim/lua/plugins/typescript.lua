-- TypeScript/JavaScript development support
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "jsdoc",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
    },
  },
}

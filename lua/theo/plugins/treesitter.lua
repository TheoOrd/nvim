local parsers = {
  "bash",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      local installed = treesitter.get_installed()
      local missing = vim.tbl_filter(function(parser)
        return not vim.list_contains(installed, parser)
      end, parsers)

      if #missing > 0 then
        treesitter.install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("theo-treesitter-start", { clear = true }),
        pattern = {
          "bash",
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "lua",
          "markdown",
          "python",
          "typescript",
          "typescriptreact",
          "vim",
          "vimdoc",
        },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}

local augroup = vim.api.nvim_create_augroup

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("theo-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("theo-lsp-attach", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>pd", function()
      vim.diagnostic.setqflist()
      vim.cmd.copen()
    end, "Project diagnostics")
  end,
})

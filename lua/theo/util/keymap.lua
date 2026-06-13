local M = {}

function M.n(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

function M.v(lhs, rhs, desc)
  vim.keymap.set("v", lhs, rhs, { silent = true, desc = desc })
end

function M.i(lhs, rhs, desc)
  vim.keymap.set("i", lhs, rhs, { silent = true, desc = desc })
end

return M

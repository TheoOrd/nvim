if not vim.g.theo_enable_french_accents then
  return
end

local function cycle_variant(variants, codes)
  local col = vim.fn.col(".")
  if col <= 1 then
    return variants[1]
  end

  local line = vim.api.nvim_get_current_line()
  local prev_char = line:sub(col - 1, col - 1)
  local prev_nr = vim.fn.char2nr(prev_char)

  for index, code in ipairs(codes) do
    if code == prev_nr then
      local next_variant = variants[(index % #variants) + 1]
      return vim.api.nvim_replace_termcodes("<C-H>", true, false, true) .. next_variant
    end
  end

  return variants[1]
end

local function cycle_remap(key, variants, codes, desc)
  vim.keymap.set("i", "<A-" .. key .. ">", function()
    return cycle_variant(variants, codes)
  end, { desc = desc, expr = true, noremap = true, silent = true })
end

cycle_remap("e", { "é", "è", "ê", "ë", "€" }, { 169, 168, 170, 171, 172 }, "Cycle e accents")
cycle_remap("E", { "É", "È", "Ê", "Ë" }, { 137, 136, 138, 139 }, "Cycle E accents")
cycle_remap("a", { "à", "â" }, { 160, 162 }, "Cycle a accents")
cycle_remap("A", { "À", "Â" }, { 128, 130 }, "Cycle A accents")
cycle_remap("i", { "î", "ï" }, { 174, 175 }, "Cycle i accents")
cycle_remap("I", { "Î", "Ï" }, { 142, 143 }, "Cycle I accents")
cycle_remap("o", { "ô", "ö" }, { 180, 182 }, "Cycle o accents")
cycle_remap("O", { "Ô", "Ö" }, { 148, 150 }, "Cycle O accents")
cycle_remap("u", { "ù", "û", "ü" }, { 185, 187, 188 }, "Cycle u accents")
cycle_remap("U", { "Ù", "Û", "Ü" }, { 153, 155, 156 }, "Cycle U accents")

vim.keymap.set("i", "<A-c>", "ç", { desc = "Insert c cedilla" })
vim.keymap.set("i", "<A-C>", "Ç", { desc = "Insert capital c cedilla" })

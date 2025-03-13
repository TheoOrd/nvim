local function cycle_variant(variants, codes)

  local col = vim.fn.col('.')
  if col <= 1 then
    return variants[1]
  end

  local line = vim.api.nvim_get_current_line()
  local prev_char = line:sub(col - 1, col - 1)
  local prev_nr = vim.fn.char2nr(prev_char)

  vim.notify(vim.inspect(prev_nr))

  local idx = nil
  for i, code in ipairs(codes) do
    if code == prev_nr then
      idx = i
      break
    end
  end

  if idx then
    local next_variant = variants[(idx % #variants) + 1]
    return vim.api.nvim_replace_termcodes('<C-H>', true, false, true) .. next_variant
  else
    return variants[1]
  end
end

local function cycle_remap(key, variants, codes)
	vim.keymap.set('i', '<A-' .. key .. '>', function()
		return cycle_variant(variants, codes)
	end, { expr = true, noremap = true, silent = true })
end

cycle_remap('e', { 'é', 'è', 'ê', 'ë', '€' }, { 169, 168, 170, 171, 172 })
cycle_remap('E', { 'É', 'È', 'Ê', 'Ë' }, { 137, 136, 138, 139 })

cycle_remap('a', { 'à', 'â' }, { 160, 162 })
cycle_remap('A', { 'À', 'Â' }, { 128, 130 })

cycle_remap('i', { 'î', 'ï' }, { 174, 175 })
cycle_remap('I', { 'Î', 'Ï' }, { 142, 143 })

cycle_remap('o', { 'ô', 'ö' }, { 180, 182 })
cycle_remap('O', { 'Ô', 'Ö' }, { 148, 150 })

cycle_remap('u', { 'ù', 'û', 'ü' }, { 185, 187, 188 })
cycle_remap('U', { 'Ù', 'Û', 'Ü' }, { 153, 155, 156 })

vim.keymap.set('i', '<A-c>', 'ç')
vim.keymap.set('i', '<A-C>', 'Ç')

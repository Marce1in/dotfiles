-- Early filetype detection for Blade templates
-- This runs before plugin/init.lua to ensure proper detection

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

-- Also handle via autocmd for edge cases
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.blade.php",
  callback = function()
    vim.bo.filetype = "blade"
  end,
})

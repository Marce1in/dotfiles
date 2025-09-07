-- lazy config
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load vim opts
require("vim-opts")
require("vim-keys")

-- load plugins
require("lazy").setup("plugins", { rocks = { hererocks = true }, ui = { border = "single" } })

-- setup notification system
vim.notify = require("fidget").notify

-- setup colorscheme
vim.cmd([[colorscheme gruvbox]])

-- Change colorColumn after colorscheme was set
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#101010" })

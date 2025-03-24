vim.keymap.set("n", "<C-u>", "<C-o>")

vim.keymap.set("n", "<C-o>", ":bn<CR>")
vim.keymap.set("n", "<C-p>", ":bp<CR>")
vim.keymap.set("n", "<C-d>", ":bd<CR>")

-- Desliga as setas
vim.keymap.set({ "i", "n", "v" }, "<Up>", "<C-W>k")
vim.keymap.set({ "i", "n", "v" }, "<Down>", "<C-W>j")
vim.keymap.set({ "i", "n", "v" }, "<Left>", "<C-W>h")
vim.keymap.set({ "i", "n", "v" }, "<Right>", "<C-W>l")

vim.keymap.set({ "i", "n", "v" }, "<C-Up>", ":resize -3<CR>")
vim.keymap.set({ "i", "n", "v" }, "<C-Down>", ":resize +3<CR>")
vim.keymap.set({ "i", "n", "v" }, "<C-Left>", ":vertical resize -3<CR>")
vim.keymap.set({ "i", "n", "v" }, "<C-Right>", ":vertical resize +3<CR>")

vim.keymap.set({ "n", "v" }, "<leader><Top>", "<C-w>t<C-w>K")
vim.keymap.set({ "n", "v" }, "<leader><Right>", "<C-w>t<C-w>H")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- Muda o diretório para o diretório do arquivo aberto
-- Se estiver dentro de um repositório, muda para dentro do repositório
vim.keymap.set("n", "cd", function()
	local file_dir = vim.fn.expand("%:h")
	local repo_root = vim.fs.root(file_dir, ".git")

	if repo_root then
		vim.cmd("cd " .. repo_root)
	else
		vim.cmd("cd " .. file_dir)
	end
end)

-- Muda o diretório para o diretório do arquivo aberto
vim.keymap.set("n", "<leader>cd", ":cd %:h<CR>")


-- Mostra o'que foi modificado usando o git
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})

-- Mostra em uma janelinha o erro de um linha de código
vim.keymap.set("n", "Ç", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Crtl + c e Crtl + v
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "n" }, "<leader>p", '"+p')

-- Desfocar do terminal
vim.keymap.set("t", "<C-x>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("n", "<C-t>", ":term <CR>", { silent = true })

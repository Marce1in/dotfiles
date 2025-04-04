vim.api.nvim_set_keymap('n', '<C-O>', '<C-U>', { noremap = true, silent = true })

-- Manipulação de buffer
vim.keymap.set("n", "<C-o>", "<Cmd>bn<CR>")
vim.keymap.set("n", "<C-p>", "<Cmd>bp<CR>")
vim.keymap.set("n", "<C-d>", "<Cmd>bd<CR>")

-- Desliga as setas e faz elas apenas aumentarem as janelas
vim.keymap.set({ "n", "v" }, "<Up>", "<Cmd>resize +10<CR>")
vim.keymap.set({ "n", "v" }, "<Down>", "<Cmd>resize -10<CR>")
vim.keymap.set({ "n", "v" }, "<Left>", "<Cmd>vertical resize +10<CR>")
vim.keymap.set({ "n", "v" }, "<Right>", "<Cmd>vertical resize -10<CR>")

vim.keymap.set({ "n", "v" }, "<C-w>d", "<Cmd>close<CR>")

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
vim.keymap.set("n", "<leader>cd", "<Cmd>cd %:h<CR>")

-- Mostra o'que foi modificado usando o git
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", {})

-- Mostra em uma janelinha o erro de um linha de código
vim.keymap.set("n", "Ç", "<Cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Crtl + c e Crtl + v
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "n" }, "<leader>p", '"+p')

-- Desfocar e abrir terminal
vim.keymap.set("t", "<C-x>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("n", "<C-t>", "<Cmd>10split|term<CR>", { silent = true })

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

-- pula pra tras
vim.keymap.set('n', '<C-u>', '<C-o>')

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

-- Abre o .env de um projeto
vim.keymap.set('n', '<leader>.', function()
  local root = vim.fs.root(0, ".git")

  local target_dir = root or vim.fn.getcwd()
  local env_path = target_dir .. "/.env"

  if vim.fn.filereadable(env_path) == 1 then
    vim.cmd("edit " .. env_path)
  else
    local mode = root and "Git Root" or "CWD"
    print(string.format(".env not found"))
  end
end)

-- Muda o diretório para o diretório do arquivo aberto
vim.keymap.set("n", "<leader>cd", "<Cmd>cd %:h<CR>")

-- Mostra em uma janelinha o erro de um linha de código
vim.keymap.set("n", "Ç", "<Cmd>lua vim.diagnostic.open_float({ border = 'single' })<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Crtl + c e Crtl + v
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "n" }, "<leader>p", '"+p')

-- Desfocar e abrir terminal
vim.keymap.set("t", "<C-x>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("n", "<C-t>", "<Cmd>10split|term<CR>", { silent = true })


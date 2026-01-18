return {
	"tpope/vim-fugitive",

	keys = {
		{
			"<leader>gg",
			function()
				local tabpage = vim.api.nvim_get_current_tabpage()
				local win_list = vim.api.nvim_tabpage_list_wins(tabpage)

				for _, win in ipairs(win_list) do
					local buf = vim.api.nvim_win_get_buf(win)
					-- Check if the buffer in this window is a fugitive_status buffer
					local is_fugitive = vim.fn.getbufvar(buf, 'fugitive_status')

					if is_fugitive ~= "" and is_fugitive ~= nil then
						vim.api.nvim_win_close(win, false)
						return
					end
				end

				local width = math.floor(vim.o.columns * 0.25)

				vim.cmd('vertical keepalt Git')
				vim.cmd('vertical resize ' .. width)
			end,
		}
	}
}

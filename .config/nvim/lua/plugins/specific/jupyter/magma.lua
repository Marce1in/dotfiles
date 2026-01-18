return {
    "benlubas/molten-nvim",

    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",

    init = function()
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20

        vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

        vim.g.molten_wrap_output = true
        vim.g.molten_virt_text_output = true

        vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
        vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })

        vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
        vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
        vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
        vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

        -- if you work with html outputs:
        vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })

        -- automatically import output chunks from a jupyter notebook
        -- tries to find a kernel that matches the kernel in the jupyter notebook
        -- falls back to a kernel that matches the name of the active venv (if any)
        local imb = function(e) -- init molten buffer
            vim.schedule(function()
                local kernels = vim.fn.MoltenAvailableKernels()
                local try_kernel_name = function()
                    local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
                    return metadata.kernelspec.name
                end
                local ok, kernel_name = pcall(try_kernel_name)
                if not ok or not vim.tbl_contains(kernels, kernel_name) then
                    kernel_name = nil
                    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
                    if venv ~= nil then
                        kernel_name = string.match(venv, "/.+/(.+)")
                    end
                end
                if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
                    vim.cmd(("MoltenInit %s"):format(kernel_name))
                end
                vim.cmd("MoltenImportOutput")
            end)
        end

        -- automatically import output chunks from a jupyter notebook
        vim.api.nvim_create_autocmd("BufAdd", {
            pattern = { "*.ipynb" },
            callback = imb,
        })

        -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = { "*.ipynb" },
            callback = function(e)
                if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
                    imb(e)
                end
            end,
        })

        -- automatically export output chunks to a jupyter notebook on write
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.ipynb" },
            callback = function()
                if require("molten.status").initialized() == "Molten" then
                    vim.cmd("MoltenExportOutput!")
                end
            end,
        })
    end,
}

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    event = "VeryLazy",

    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")

        harpoon.setup {
            settings = {
                save_on_toggle = true,
                mark_branch = true,
            }
        }

        vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>h", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-o>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-p>", function() harpoon:list():next() end)
    end

}
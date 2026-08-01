local ensure_installed = {
    "arduino",
    "bash",
    "bibtex",
    "blade",
    "c",
    "c_sharp",
    "clojure",
    "css",
    "csv",
    "dart",
    "desktop",
    "diff",
    "dockerfile",
    "editorconfig",
    "elixir",
    "fennel",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "heex",
    "html",
    "hyprlang",
    "javascript",
    "json",
    "kdl",
    "kotlin",
    "lua",
    "make",
    "markdown",
    "nginx",
    "nix",
    "pem",
    "php",
    "php_only",
    "prisma",
    "properties",
    "python",
    "query",
    "rust",
    "solidity",
    "sql",
    "ssh_config",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "zig",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        dependencies = { "windwp/nvim-ts-autotag" },

        build = function()
            local treesitter = require("nvim-treesitter")
            treesitter.install(ensure_installed, { summary = true, max_jobs = 1 }):wait(300000)
            treesitter.update(nil, { summary = true, max_jobs = 1 }):wait(300000)
        end,

        opts = {},

        config = function(_, opts)
            local treesitter = require("nvim-treesitter")

            treesitter.setup(opts)

            vim.treesitter.language.register("bash", "sh")
            vim.treesitter.language.register("c_sharp", "cs")
            vim.treesitter.language.register("git_config", "gitconfig")
            vim.treesitter.language.register("git_rebase", "gitrebase")
            vim.treesitter.language.register("ssh_config", "sshconfig")

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
                callback = function(args)
                    local ok = pcall(vim.treesitter.start, args.buf)
                    if not ok then
                        return
                    end

                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}

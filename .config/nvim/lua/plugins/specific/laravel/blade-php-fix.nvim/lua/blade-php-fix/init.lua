-- blade-php-fix.nvim
-- Provides proper treesitter injection queries for PHP in blade files

local M = {}

M.config = {
  -- Parsers required for proper blade PHP highlighting
  parsers = { "blade", "php", "php_only", "html" },
}

--- Setup function for the plugin
---@param opts table|nil Optional configuration
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Register blade parser configuration with nvim-treesitter
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  -- Only configure if not already set
  if not parser_config.blade then
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }
  end

  -- Set up filetype detection for *.blade.php files
  vim.filetype.add({
    pattern = {
      [".*%.blade%.php"] = "blade",
    },
  })

  -- Auto-install required parsers if nvim-treesitter is configured for it
  local ok, ts_install = pcall(require, "nvim-treesitter.install")
  if ok then
    -- Check and install missing parsers
    for _, parser in ipairs(M.config.parsers) do
      local is_installed = pcall(vim.treesitter.language.inspect, parser)
      if not is_installed then
        -- Queue parser for installation
        vim.schedule(function()
          pcall(ts_install.ensure_installed, parser)
        end)
      end
    end
  end

  -- Add the plugin's after directory to runtimepath for query files
  local plugin_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h")
  local after_dir = plugin_dir .. "/after"

  if vim.fn.isdirectory(after_dir) == 1 then
    vim.opt.runtimepath:append(after_dir)
  end

  -- Force full parse of blade files to ensure php_only injections are parsed
  -- This is needed because vim.treesitter.start() doesn't parse all injections by default
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "blade",
    callback = function(args)
      vim.schedule(function()
        local bufnr = args.buf
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        -- Get the parser and force a full parse including all injections
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "blade")
        if ok and parser then
          -- parse(true) forces parsing of the entire document including all injections
          parser:parse(true)
        end
      end)
    end,
  })
end

return M

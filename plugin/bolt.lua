
local treesitter_path = vim.env.VIM_BOLT_TS_PATH
local lsp_binary_path = vim.env.VIM_BOLT_LSP_PATH or 'bolt-language-server'

local parsers = require('nvim-treesitter.parsers')
local install_info
if treesitter_path == nil then
  install_info = {
    url = 'https://github.com/boltlang/tree-sitter-bolt',
    generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
    queries = 'queries', -- also install queries from given directory
  }
else
  install_info = {
    path = treesitter_path,
    generate = true,
    generate_from_json = false,
    queries = 'queries', -- symlink queries from given directory
  }
end
parsers.bolt = {
  install_info = install_info,
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "bolt",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.lsp.config('boltls', {
  cmd = { lsp_binary_path },
  filetypes = { 'bolt', 'toml' },
  -- Bolt files, and of TOML files only `bolt.toml`, whose errors the server
  -- reports in it. Not calling `on_dir` keeps the server away from a
  -- buffer, like a `Cargo.toml`.
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if vim.bo[bufnr].filetype == 'toml' and vim.fs.basename(name) ~= 'bolt.toml' then
      return
    end
    -- The package's directory, or the file's own for a loose file.
    on_dir(vim.fs.root(bufnr, { 'bolt.toml' }) or vim.fs.dirname(name))
  end,
})


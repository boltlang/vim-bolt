
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
  filetypes = { 'bolt' },
})


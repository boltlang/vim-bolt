Bolt in Vim
===========

This repository contains the Vim plugin for the Bolt programming language.

## Installation

Install using your favorite package manager.

**vim-plug**
```vim
Plug 'boltlang/vim-bolt'
```

**packer.nvim**
```lua
use 'boltlang/vim-bolt'
```

**Lazy.nvim**
```lua
{
  'boltlang/vim-bolt',
  ft = { 'bolt' },
}
```

## Configuration

The plugin accepts optionally the following environment variables:

| Name                | Description                                                  |
|---------------------|--------------------------------------------------------------|
| `VIM_BOLT_LSP_PATH` | Path to the Bolt language server binary                      |
| `VIM_BOLT_TS_PATH`  | The location of a local copy of the Bolt tree-sitter grammar |

## Developing

1. Fork and clone the repository:

   ```sh
   gh repo fork boltlang/vim-bolt
   ```

2. Make your package manager use the local version of the plugin, like so:

   **vim-plug**
   ```vim
   Plug '~/path/to/vim-bolt'
   ```

   **packer.nvim**
   ```lua
   use '~/path/to/vim-bolt'
   ```

3. Start hacking!

## License

Just like Bolt, this software is licensed under the MIT license.


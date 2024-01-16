# Neovim LSP client discussion

## Prerequisites 

What do we need for LSP set-up:
1. Neovim v0.8 or greater
2. A language server
3. Some lua code for each language server

## language Server

A language server is an external program that follows the Language Server Protocol. The LSP specification defines what type of messages a language server can receive, and also how it should respond. The idea here is that any tool that follows the LSP specification can communicate with a language server.

And so the language server is the thing that analyzes our source code and it can tell the editor what to do.

## Basic Usage

Before we write any code we should learn how to use the language server. The first piece of information we need is the command that starts the server. This should be in the official documentation of said server.

If we can't find the basic usage in the documentation we can go to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)'s github repository. In there we look for a folder called [server_configurations](https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations), this contains configuration files for a bunch of language servers.

## Quick start

1. Install a language server e.g: pyright
   ```bash
   brew install pyright
   ```
2. Add the language server setup to your init.lua.
   ```bash
   require'lspconfig'.pyright.setup{}
   ```
3. Launch Nvim, the language server will attach and provide diagnostics.
   ```bash
   nvim main.py
   ```
4. Run :LspInfo to see the status or to troubleshoot.
   
5. See [Suggested configuration](#Suggested-configuration) to setup common mappings and omnifunc completion.

See [server_configurations.md](doc/server_configurations.md) (`:help lspconfig-all` from Nvim) for the full list of configs, including installation instructions and additional, optional, customization suggestions for each language server. For servers that are not on your system path (e.g., `jdtls`, `elixirls`), you must manually add `cmd` to the `setup` parameter. Most language servers can be installed in less than a minute.

## Suggested configuration

nvim-lspconfig does not set keybindings or enable completion by default. The following example configuration provides suggested keymaps for the most commonly used language server functions, and manually triggered completion with omnifunc (\<c-x\>\<c-o\>).

```lua
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
```

Manual, triggered completion is provided by Nvim's builtin omnifunc. For *auto*completion, a general purpose [autocompletion plugin](https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion) is required.

## Troubleshooting

If you have an issue, the first step is to reproduce with a [minimal configuration](https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua).

The most common reasons a language server does not start or attach are:

1. The language server is not installed. nvim-lspconfig does not install language servers for you. You should be able to run the `cmd` defined in each server's Lua module from the command line and see that the language server starts. If the `cmd` is an executable name instead of an absolute path to the executable, ensure it is on your path.
2. Missing filetype plugins. Certain languages are not detecting by vim/neovim because they have not yet been added to the filetype detection system. Ensure `:set ft?` shows the filetype and not an empty value.
3. Not triggering root detection. **Some** language servers will only start if it is opened in a directory, or child directory, containing a file which signals the *root* of the project. Most of the time, this is a `.git` folder, but each server defines the root config in the lua file. See [server_configurations.md](doc/server_configurations.md) or the source for the list of root directories.
4. You must pass `on_attach` and `capabilities` for **each** `setup {}` if you want these to take effect.
5. **Do not call `setup {}` twice for the same server**. The second call to `setup {}` will overwrite the first.

Before reporting a bug, check your logs and the output of `:LspInfo`. Add the following to your init.vim to enable logging:

```lua
vim.lsp.set_log_level("debug")
```

Attempt to run the language server, and open the log with:

```
:LspLog
```
Most of the time, the reason for failure is present in the logs.

## Commands

* `:LspInfo` shows the status of active and configured language servers.
* `:LspStart <config_name>` Start the requested server name. Will only successfully start if the command detects a root directory matching the current config. Pass `autostart = false` to your `.setup{}` call for a language server if you would like to launch clients solely with this command. Defaults to all servers matching current buffer filetype.
* `:LspStop <client_id>` Defaults to stopping all buffer clients.
* `:LspRestart <client_id>` Defaults to restarting all buffer clients.

## Wiki

See the [wiki](https://github.com/neovim/nvim-lspconfig/wiki) for additional topics, including:

* [Automatic server installation](https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers#automatically)
* [Snippets support](https://github.com/neovim/nvim-lspconfig/wiki/Snippets)
* [Project local settings](https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings)
* [Recommended plugins for enhanced language server features](https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins)

## What to do if there is any problems 

If you are missing a language server on the list in [server_configurations.md](doc/server_configurations.md), contributing
a new configuration for it helps others, especially if the server requires special setup. Follow these steps:

1. Read [CONTRIBUTING.md](CONTRIBUTING.md).
2. Create a new file at `lua/lspconfig/server_configurations/SERVER_NAME.lua`.
    - Copy an [existing config](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/)
      to get started. Most configs are simple. For an extensive example see
      [texlab.lua](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/texlab.lua).
3. Ask questions on [GitHub Discussions](https://github.com/neovim/neovim/discussions) or in the [Neovim Matrix room](https://app.element.io/#/room/#neovim:matrix.org).   

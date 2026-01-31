
# My Neovim Configuration

## Introduction

This is my personal Neovim configuration, optimized for web development and general-purpose programming. It is built on top of the latest Neovim features and leverages the power of Lua for configuration.

## Features

*   **Fast & Lightweight:** Using `lazy.nvim` for plugin management, the startup time is optimized.
*   **Modern UI:** A clean and modern look and feel with `noice.nvim` and a custom statusline.
*   **Powerful LSP:** Full-featured LSP support with `nvim-lspconfig` and `mason.nvim`.
*   **Debugging:** In-editor debugging with `nvim-dap`.
*   **Git Integration:** Seamless Git integration with `gitsigns.nvim`.
*   **And much more...**

## Installation

1.  Clone this repository to your `~/.config/nvim` directory:
    ```bash
    git clone https://github.com/your-username/your-repo-name.git ~/.config/nvim
    ```
2.  Start Neovim:
    ```bash
    nvim
    ```
    The plugins will be automatically installed on the first run.

## Plugins

Here is a list of the plugins used in this configuration:

| Plugin | Description |
|---|---|
| [lazy.nvim](https.github.com/folke/lazy.nvim) | A modern plugin manager for Neovim |
| [nvim-treesitter](https.github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting and code parsing |
| [nvim-lspconfig](https.github.com/neovim/nvim-lspconfig) | A collection of configurations for the built-in LSP client |
| [mason.nvim](https.github.com/williamboman/mason.nvim) | Portable package manager for Neovim that runs everywhere you need it |
| [nvim-dap](https.github.com/mfussenegger/nvim-dap) | A Debug Adapter Protocol client implementation for Neovim |
| [gitsigns.nvim](https.github.com/lewis6991/gitsigns.nvim) | Git integration for Neovim |
| [noice.nvim](https.github.com/folke/noice.nvim) | Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu |
| [trouble.nvim](https.github.com/folke/trouble.nvim) | A pretty list for showing diagnostics, references, telescope results, quickfix and location lists |
| [conform.nvim](https.github.com/stevearc/conform.nvim) | Lightweight yet powerful formatter plugin for Neovim |
| [nvim-lint](https.github.com/mfussenegger/nvim-lint) | An asynchronous linter plugin for Neovim |
| [nvim-autopairs](https.github.com/windwp/nvim-autopairs) | A super powerful autopair plugin for Neovim |
| [nvim-surround](https.github.com/kylechui/nvim-surround) | A plugin for adding/changing/deleting surrounding delimiter pairs |
| [todo-comments.nvim](https.github.com/folke/todo-comments.nvim) | Highlight, list and search for todo comments in your projects |
| [oil.nvim](https.github.com/stevearc/oil.nvim) | A Neovim plugin that lets you edit your filesystem like a buffer |
| [grug-far.nvim](https.github.com/grugnog/grug-far.nvim) | A plugin for running search and replace across your project |
| [harpoon](https.github.com/ThePrimeagen/harpoon) | A plugin for managing a list of files to quickly jump between |
| [neotest](https.github.com/nvim-neotest/neotest) | An extensible framework for interacting with tests within Neovim |
| [nvim-navic](https.github.com/SmiteshP/nvim-navic) | A simple statusline component that shows your current code context |
| [nvim-web-devicons](https.github.com/kyazdani42/nvim-web-devicons) | A file icon plugin for Neovim |
| [copilot.lua](https.github.com/github/copilot.lua) | A Neovim plugin for GitHub Copilot |
| [rest.nvim](https.github.com/rest-nvim/rest.nvim) | A fast Neovim http client written in Lua |
| [sidekick.nvim](https.github.com/sidekick-neovim/sidekick.nvim) | A side panel for Neovim that displays context-aware information |
| [snacks.nvim](https.github.com/pascalkuthe/snacks.nvim) | A plugin for showing inline diagnostics |
| [blink.nvim](https.github.com/pascalkuthe/blink.nvim) | A plugin for showing inline diagnostics |
| [markdown-preview.nvim](https.github.com/iamcco/markdown-preview.nvim) | A markdown preview plugin for Neovim |
| [rust-tools.nvim](https.github.com/simrat39/rust-tools.nvim) | A plugin for Rust development in Neovim |
| [vim-bbye](https.github.com/moll/vim-bbye) | A plugin for closing buffers without closing the window |

## Custom Configuration

The custom configuration is located in the `lua` directory. Here is a brief overview of the files:

| File | Description |
|---|---|
| `autocmds.lua` | Custom autocommands |
| `banners.lua` | Some cool banners for the dashboard |
| `colors.lua` | Color scheme configuration |
| `filetype.lua` | Custom filetype definitions |
| `icons.lua` | Icon configuration for `nvim-web-devicons` |
| `lsp.lua` | LSP configuration |
| `maps.lua` | Key mappings |
| `opts.lua` | Neovim options |
| `plugs.lua` | Plugin management with `lazy.nvim` |
| `prompts.lua` | Custom prompts |
| `utils.lua` | Utility functions |
| `statuslinee/` | Custom statusline configuration |

## Screenshots

*(You can add your screenshots here)*

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

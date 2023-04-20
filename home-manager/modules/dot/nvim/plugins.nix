{ pkgs, ... }:

with pkgs.vimPlugins; [
# Dependences
  nvim-web-devicons
# Misc
  vim-visual-multi
  trouble-nvim
{
  plugin = toggleterm-nvim;
  type = "lua";
  config = ''
    require("toggleterm").setup{
      open_mapping = [[<c-\>]],
    }
  '';
}
{
  plugin = indent-blankline-nvim;
  type = "lua";
  config = ''
    vim.opt.termguicolors = true
    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
    
    vim.opt.list = true
    vim.opt.listchars:append "space:⋅"
    vim.opt.listchars:append "eol:↴"
    
    require("indent_blankline").setup {
        space_char_blankline = " ",
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
    }
  '';
}
{
  plugin = undotree;
}
{
  plugin = lualine-nvim;
  type = "lua";
  config = ''
    require("lualine").setup {
      options = {
        icons_enabled = false,
        section_separators = "", 
        component_separators = ""

      }
    }
  '';
}
{
  plugin = bufferline-nvim;
  type = "lua";
  config = ''
    vim.opt.termguicolors = true
    require("bufferline").setup {
      options = {
        -- 使用 nvim 内置lsp
          diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
          offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
          }}
      }
    }
  '';
}
{
  plugin = telescope-nvim;
}
{
  plugin = nvim-tree-lua;
  type = "lua";
  config = ''
    require('nvim-tree').setup ({
        filters = {
        dotfiles = true,
        },
        })
  '';
}
{
  plugin = nvim-lspconfig;
  type = "lua";
  config = ''
    require'lspconfig'.marksman.setup {}
  require'lspconfig'.pyright.setup {}
  require'lspconfig'.rust_analyzer.setup {}
  require'lspconfig'.rnix.setup {}
  require'lspconfig'.yamlls.setup {}
  require'lspconfig'.stylelint_lsp.setup {
    settings = {
      autoFixOnFormat = true;
      autoFixOnSave = true;
    }
  }
  local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    require'lspconfig'.jsonls.setup {
      capabilities = capabilities,
    }
  require'lspconfig'.cssls.setup {
    capabilities = capabilities,
  }
  require'lspconfig'.html.setup {
    capabilities = capabilities,
  }
  '';
}
lspkind-nvim
vim-vsnip
cmp-nvim-lsp
cmp-path
cmp-buffer
cmp-cmdline
cmp-vsnip
{
  plugin = nvim-cmp;
  type = "lua";
  config = ''
    local lspkind = require('lspkind')
    local cmp = require'cmp'

    cmp.setup {
      -- 指定 snippet 引擎
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
            end,
        },
                -- 来源
                  sources = cmp.config.sources({
                      { name = 'nvim_lsp' },
                      { name = 'vsnip' },
                      }, { { name = 'buffer' },
                      { name = 'path' }
                      }),

                -- 快捷键
                  mapping = cmp.mapping.preset.insert({
                      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                      ['<C-j>'] = cmp.mapping.scroll_docs(4),
                      ['<C-e>'] = cmp.mapping.complete(),
                      ['<C-q>'] = cmp.mapping.abort(),
                      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                      }),
                -- 使用lspkind-nvim显示类型图标
                  formatting = {
                    format = lspkind.cmp_format({
                        with_text = true, -- do not show text alongside icons
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        before = function (entry, vim_item)
                        -- Source 显示提示来源
                        vim_item.menu = "["..string.upper(entry.source.name).."]"
                        return vim_item
                        end
                        })
                  },
    }

  -- Use buffer source for `/`.
    cmp.setup.cmdline('/', {
        sources = {
        { name = 'buffer' }
        }
        })

  -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' }
            }, {
            { name = 'cmdline' }
            })
        })
  '';
}
{
  plugin = (nvim-treesitter.withPlugins (
        plugins: with plugins; [ 
        tree-sitter-nix
        tree-sitter-python
        tree-sitter-rust
        tree-sitter-go
        tree-sitter-css
        tree-sitter-scss
        tree-sitter-yaml
        tree-sitter-toml
        tree-sitter-html
        tree-sitter-lua
        tree-sitter-javascript
        tree-sitter-markdown
        tree-sitter-json
        ]
        ));
  type = "lua";
  config = ''
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
                incremental_selection = {
                  enable = true,
                  keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    node_decremental = '<BS>',
                    scope_incremental = '<TAB>',
                  }
                },
                indent = {
                  enable = true
                }
    }
  vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.cmd('set nofoldenable')
    '';
}
]

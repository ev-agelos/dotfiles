-- Install packer if not already installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('globals')
require('options')  -- some plugin overwrites shopt+=a
require('mappings')
require('autocmd')
require('functions')


require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Packer can manage itself
  use {'nvim-lualine/lualine.nvim', config="require('config.lualine')", requires={'kyazdani42/nvim-web-devicons', opt=true}}
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use {'ggandor/leap.nvim'}
  use {"elihunter173/dirbuf.nvim"}
  use 'junegunn/vim-peekaboo'
  use {'mhinz/vim-startify', config="require('config.startify')"}
  use {'ap/vim-buftabline', config="require('config.buftabline')"}
  use {'mbbill/undotree', opt=true, cmd={'UndotreeToggle'}, config="require('config.undotree')"}
  use {'fatih/vim-go', ft={'go'}}

  use 'kyazdani42/nvim-web-devicons'
  use {"akinsho/toggleterm.nvim", tag='*', config="require('config.toggleterm')"}
  --Surroundings
  use 'tpope/vim-commentary'
  --use '9mm/vim-closer'
  use {'tmsvg/pear-tree', config="require('config.pear_tree')"}
  --Effects
  use {
      "shortcuts/no-neck-pain.nvim",
      tag = "*",
      config="require('no-neck-pain').setup({enableOnVimEnter=true,width=130})"
  }
  use {
      'declancm/cinnamon.nvim',
      config="require('cinnamon').setup{extra_keymaps=false}"
  }
  use 'machakann/vim-highlightedyank'
  ----System
  use 'tpope/vim-eunuch'
  use {'lambdalisue/suda.vim', config="require('config.vim_suda')"}
  --Programming
  use {"folke/trouble.nvim", requires="kyazdani42/nvim-web-devicons", config="require('trouble').setup{mode='document_diagnostics',indent_lines=false}"}
  use {'ray-x/lsp_signature.nvim', config="require('lsp_signature').setup()"}
  use {'Vimjas/vim-python-pep8-indent'}
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config="require('config.treesitter')"}


  use 'nvim-lua/plenary.nvim'

  use {'williamboman/mason.nvim'}
  use {"williamboman/mason-lspconfig.nvim"}
  use {'neovim/nvim-lspconfig', config="require('config.lspconfig')"}
  use {
        'jose-elias-alvarez/null-ls.nvim',
        config=function() require("null-ls").setup({
            debug=true,
            sources = {
                -- mypy doesnt work: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1208
                -- require('null-ls').builtins.diagnostics.mypy,

                require("null-ls").builtins.formatting.black,
                require("null-ls").builtins.formatting.isort.with({
                    extra_args={"--profile=black"},
                }),
                -- require("null-ls").builtins.diagnostics.pyproject_flake8,  -- pyflakes, pycodestyle, mccabe
                -- require("null-ls").builtins.diagnostics.vulture,
                -- avoid using through pylama cause can't use pyproject.toml
                -- require("null-ls").builtins.diagnostics.pydocstyle.with({
                --     extra_args={"--config=$ROOT/pyproject.toml"},
                -- }),
                -- require('null-ls').builtins.diagnostics.pylint,
            },
        })
        end
    }
  use {
      'nvim-telescope/telescope.nvim',
      config="require('config.telescope')",
      requires={
          {'nvim-lua/plenary.nvim'},
          {'kyazdani42/nvim-web-devicons', opt=true},
          {'nvim-treesitter/nvim-treesitter', opt=true},
      }
  }
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use({"L3MON4D3/LuaSnip", tag = "v1.*"})
  use {'hrsh7th/nvim-cmp', config="require('config.cmp')"}
  use 'onsails/lspkind-nvim'  -- icons on completion menu

  --Version Control
  use {'junegunn/gv.vim', opt=true, cmd={'GV'}}
  use {'lewis6991/gitsigns.nvim', config="require('config.gitsigns')"}

  -- ?
  use {'iamcco/markdown-preview.nvim', ft={'markdown'}, run="vim.fn['mkdp#util#install']()"}

  use 'folke/lsp-colors.nvim'
  --Colorschemes
  use 'habamax/vim-habanight'
  use 'iojani/silenthill.vim'
  --light ones
  use 'habamax/vim-psionic'
  use 'aunsira/macvim-light'
  use 'reedes/vim-colors-pencil'
  use 'Mofiqul/adwaita.nvim'
  use {'ms-jpq/chadtree', branch='chad', run='python3 -m chadtree deps'}

end)
require('highlights')

{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      xclip
      nil
      ripgrep
      fd
      lazygit
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugin/lsp.lua;
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require(\"Comment\").setup()";
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugin/cmp.lua;
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/telescope.lua;
      }
      telescope-fzf-native-nvim
      cmp_luasnip
      cmp-nvim-lsp
      friendly-snippets
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/lualine.lua;
      }
      nvim-web-devicons
      luasnip
      lazydev-nvim
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./plugin/treesitter.lua;
      }

      vim-nix

      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/tokyonight.lua;
      }

      vim-tmux-navigator
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/neo-tree.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./keymaps.lua}
    '';
  };
}

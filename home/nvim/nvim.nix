{
  config,
  pkgs,
  ...
}:
{
  stylix.targets.neovim.enable = false;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # language servers
      lua-language-server
      nil
      pyright
      tinymist
      haskell-language-server
      sqls

      # formater
      nixfmt-rfc-style
      stylua
      ruff

      # extra
      fd
      lazygit
      ripgrep
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      cmp-nvim-lsp
      cmp_luasnip
      comment-nvim
      friendly-snippets
      gitsigns-nvim
      lazydev-nvim
      lualine-nvim
      luasnip
      mini-surround
      neo-tree-nvim
      none-ls-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      snacks-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      tokyonight-nvim
      vim-tmux-navigator
      persistence-nvim
    ];
  };
  home.activation.linkMyFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf -T /home/tryskyfa/nix/home/nvim/config/ ~/.config/nvim
  '';
}

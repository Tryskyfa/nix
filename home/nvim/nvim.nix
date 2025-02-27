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
      lua-language-server
      wl-clipboard
      nil
      ripgrep
      fd
      lazygit
      # formater
      nixfmt-rfc-style
      stylua
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
    ];
  };
  home.activation.linkMyFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf -T /home/tryskyfa/nix/home/nvim/config/ ~/.config/nvim
  '';
}

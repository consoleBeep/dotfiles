{pkgs, ...}: {
  imports = [
    ./lsp
    ./snacks
    ./treesitter
    ./cmp.nix
    ./comment.nix
    ./dap.nix
    ./gitsigns.nix
    ./nvim-autopairs.nix
    ./nvim-colorizer.nix
    ./telescope.nix
    ./tmux-navigator.nix
  ];

  programs.nixvim = {
    plugins = {
      bufferline.enable = true;
      crates-nvim.enable = true;
      direnv.enable = true;
      fidget.enable = true;
      hardtime.enable = true;
      indent-blankline.enable = true;
      lspkind = import ./lspkind.nix;
      lualine = import ./lualine.nix;
      luasnip = import ./luasnip.nix pkgs;
      markdown-preview = import ./markdown-preview.nix;
      neocord.enable = true;
      noice.enable = true;
      nvim-tree = import ./nvim-tree.nix;
      otter.enable = true;
      rustaceanvim = import ./rustaceanvim.nix pkgs;
      sleuth.enable = true;
      trouble.enable = true;
      web-devicons.enable = true;
      which-key = import ./which-key.nix;
    };

    extraPlugins = with pkgs.vimPlugins; [
      cellular-automaton-nvim
      vim-be-good
    ];
  };
}

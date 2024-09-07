{
  imports = [
    ./lsp
    ./auto-save.nix
    ./cellular-automaton.nix
    ./dap.nix
    ./dashboard.nix
    ./gitsigns.nix
    ./hardtime.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./neo-tree.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./treesitter.nix
  ];

  programs.nixvim.plugins = {
    bufferline.enable = true;
    crates-nvim.enable = true;
    direnv.enable = true;
    nvim-autopairs.enable = true;
  };
}

{inputs, ...}: {
  imports = [
    ./plugins

    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      shiftwidth = 4;

      updatetime = 100; # Faster completion.
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        key = ";";
        action = ":";
      }
    ];
  };
}

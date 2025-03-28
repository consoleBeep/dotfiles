{
  pkgs,
  config,
  ...
}: {
  programs.direnv = {
    enable = true;

    enableZshIntegration = config.programs.zsh.enable;

    silent = true;
    nix-direnv.enable = true;

    # Hash $PWD to get a fully unique cache path for any given environment.
    stdlib =
      # sh
      ''
        : ''${XDG_CACHE_HOME:=$HOME/.cache}
        declare -A direnv_layout_dirs

        direnv_layout_dir() {
          echo "''${direnv_layout_dirs[$PWD]:=$(
            echo -n "$XDG_CACHE_HOME"/direnv/layouts/
            echo -n "$PWD" | ${pkgs.perl}/bin/shasum | cut -d ' ' -f 1
          )}"
        }
      '';
  };
}

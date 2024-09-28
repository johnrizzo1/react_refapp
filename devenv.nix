{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.git ];
  # languages.rust.enable = true;
  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;
  languages.javascript.pnpm.enable = true;
  languages.typescript.enable = true;
  services.postgres.enable = true;
  enterShell = ''
    git --version
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}

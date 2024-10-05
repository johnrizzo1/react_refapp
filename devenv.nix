{ pkgs, lib, config, inputs, ... }:

{
  # packages = [ pkgs.git pkgs.pnpm ];

  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;
  languages.javascript.pnpm.enable = true;
  languages.typescript.enable = true;

  languages.python = {
    enable = true;
    venv.enable = true;
    venv.quiet = true;
    venv.requirements = ./requirements.txt;
  };

  dotenv.enable = true;
  
  services.postgres = {
    enable = true;
    listen_addresses = "0.0.0.0";
    port = 5432;
    settings = {
      log_connections = true;
      log_statement = "all";
      logging_collector = true;
      log_disconnections = true;
      log_destination = lib.mkForce "syslog";
    };

    initialDatabases = [
      {
        name = "verceldb";
        pass = "verceluser";
        user = "verceluser";
      }
    ];
  };

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

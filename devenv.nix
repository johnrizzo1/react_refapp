{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.git ];
  # languages.rust.enable = true;
  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;
  languages.javascript.pnpm.enable = true;
  languages.typescript.enable = true;
  
  dotenv.enable = true;
  
  services.postgres.enable = true;
  services.postgres.listen_addresses = "0.0.0.0";
  services.postgres.port = 5432;
  # services.postgres.initialDatabases = [
  #   { name = "verceldb"; }
  # ];

  services.postgres.settings = {
    log_connections = true;
    log_statement = "all";
    logging_collector = true;
    log_disconnections = true;
    log_destination = lib.mkForce "syslog";
  };

  services.postgres.initialDatabases = [
    {
      name = "verceldb";
      pass = "verceluser";
      user = "verceluser";
    }
  ];

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

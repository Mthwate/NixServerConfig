{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./host-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  users.users.mthwate = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdi3BSg+IH8cjyB3BaqxHkL0yuiMT7wb1Wc5rxUZMJ5uIwjMjO8IPRBh07nF4oAlUJQBUu5VLBXT7pKq3BkMHkOBO2qqjgNaXy2r3CPlRkky8M6f/iXrd7E1E8NpL3qARaP7Wke+SmJrlrmN+luvyypZUahcebh5dctkWdz/s6nQ3DY1bc3OmUCSCMj+jmFdnQ/2fwYjwEjkSYYO4iYDygzXhkyWK6eRG2y1/aMTHESPyY3716vhTPMVry9/dkDijURvzpTvdrg/9wXMVd0Xt5HXCcJvhyXkedLd9IUt09VaslTnJ2XWc1utYZA4X0F2tyGyGaFAIsGZ1krcl0r13f"
    ];
  };

  environment.systemPackages = with pkgs; [
    nano
    curl
    wget
    tmux
  ];

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    storageDriver = "btrfs";
  };

  programs.zsh.enable = true;

  services.openssh.enable = true;

  networking = {
    firewall = {
      allowedTCPPorts = [ 2377 7946 ];
      allowedUDPPorts = [ 4789 7946 ];
    };
  };

  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

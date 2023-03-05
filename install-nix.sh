#!/bin/bash

CONFIG=$1
DISK=$1

parted $DISK -- mklabel gpt
parted $DISK -- mkpart primary 512MB 100%
parted $DISK -- mkpart ESP fat32 1MB 512MB
parted $DISK -- set 2 esp on

mkfs.btrfs $DISK1
mkfs.fat -F 32 -n boot $DISK2

mount $DISK1 /mnt
mkdir -p /mnt/boot
mount $DISK2 /mnt/boot

nixos-generate-config --root /mnt

cp $CONFIG /mnt/etc/nixos/configuration.nix

#!/bin/bash

CONFIG=$1
DISK=$2

if [ "$EUID" -ne 0 ]
then
  echo "Please run as root"
  exit
fi

parted $DISK -- mklabel gpt
parted $DISK -- mkpart primary 512MB 100%
parted $DISK -- mkpart ESP fat32 1MB 512MB
parted $DISK -- set 2 esp on

mkfs.btrfs ${DISK}1
mkfs.fat -F 32 -n boot ${DISK}2

mount ${DISK}1 /mnt
mkdir -p /mnt/boot
mount ${DISK}2 /mnt/boot

nixos-generate-config --root /mnt

cp $CONFIG /mnt/etc/nixos/configuration.nix

nixos-install

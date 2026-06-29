#!/bin/sh
sudo nixos-rebuild "${1:-switch}" --flake .#Mind

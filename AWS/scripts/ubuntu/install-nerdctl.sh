#!/bin/bash
VERSION="2.2.0"

## For ubuntu 24.04
mkdir /tmp/nerdctl && cd /tmp/nerdctl

echo "Total binaries in /usr/local/bin: $(ls -la /usr/local/bin | wc -l)"

wget https://github.com/containerd/nerdctl/releases/download/v${VERSION}/nerdctl-full-${VERSION}-linux-amd64.tar.gz
# this won't override but rather add into existing paths
sudo tar -xzf nerdctl-full-${VERSION}-linux-amd64.tar.gz -C /usr/local/

echo $PATH

echo "Total binaries in /usr/local/bin After installation: $(ls -la /usr/local/bin | wc -l)"

# ] error: failed to setup UID/GID map: newuidmap 2192371 [0 1000 1 1 100000 65536] failed: : exec: "newuidmap": executable file not found in $PATH
sudo apt-get install -y uidmap


cat <<EOT | sudo tee "/etc/apparmor.d/usr.local.bin.rootlesskit"
abi <abi/4.0>,
include <tunables/global>

/usr/local/bin/rootlesskit flags=(unconfined) {
  userns,

  # Site-specific additions and overrides. See local/README for details.
  include if exists <local/usr.local.bin.rootlesskit>
}
EOT

echo "Restarting apparmor to apply the new rules"

# Restart apparmor to apply the new rules
sudo systemctl restart apparmor.service

containerd-rootless-setuptool.sh install

# Enable linger for the current user
sudo loginctl enable-linger $USER
# Reload the user services
systemctl --user daemon-reload
# # Start the user services
# systemctl --user start

nerdctl run --rm hello-world

# nerdctl --version

## For ubuntu 22.04
# https://rootlesscontaine.rs/getting-started/common/subuid/


# ] error: failed to setup UID/GID map: newuidmap 2192371 [0 1000 1 1 100000 65536] failed: : exec: "newuidmap": executable file not found in $PATH
# sudo apt-get install -y uidmap


# The cgroup v2 controller "cpu" is not delegated for the current user
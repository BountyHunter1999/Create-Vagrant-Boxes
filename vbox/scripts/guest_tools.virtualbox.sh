#!/bin/sh -eux

# Install VirtualBox Guest Additions
# This script is executed after guest additions are uploaded/attached

if [ -f /tmp/VBoxGuestAdditions.iso ]; then
  # Mount the guest additions ISO
  mkdir -p /mnt/vbox
  mount -o loop /tmp/VBoxGuestAdditions.iso /mnt/vbox
  
  # Install required packages for building guest additions
  apt-get update
  apt-get install -y build-essential dkms linux-headers-$(uname -r)
  
  # Run the installer
  /mnt/vbox/VBoxLinuxAdditions.run || true
  
  # Cleanup
  umount /mnt/vbox
  rmdir /mnt/vbox
  rm -f /tmp/VBoxGuestAdditions.iso
fi

# Ensure guest additions services are enabled
if [ -f /usr/sbin/VBoxService ]; then
  systemctl enable vboxadd-service || true
  systemctl start vboxadd-service || true
fi

# Clean up build dependencies
apt-get autoremove -y
apt-get clean


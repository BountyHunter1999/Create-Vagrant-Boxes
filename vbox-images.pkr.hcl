source "virtualbox-iso" "ubuntu-noble-amd64" {
  guest_os_type = "Ubuntu_64"
  // iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"

  # This doesn't enable SSH by default
  # iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-desktop-amd64.iso" 
  # look into sha256sums
  # iso_checksum = "sha256:faabcf33ae53976d2b8207a001ff32f4e5daae013505ac7188c9ea63988f8328"
  
  iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-live-server-amd64.iso" 
  iso_checksum = "sha256:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"

  ssh_username = "packer"
  ssh_password = "packer"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

//   guest_additions_path = "VBoxGuestAdditions_8.0.26.iso"
}

build {
  sources = ["sources.virtualbox-iso.ubuntu-noble-amd64"]
}
source "virtualbox-iso" "ubuntu-noble-amd64" {
  guest_os_type = "Ubuntu_64"
  // iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"

  boot_command         = ["<esc><esc><esc><esc>e<wait>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "<del><del><del><del><del><del><del><del>", "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter>", "<enter><f10><wait>"]

  // boot_command = [
  //   "c",
  //   "linux /casper/vmlinuz — autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort}}/",
  //   "",
  //   "initrd /casper/initrd",
  //   "",
  //   "boot",
  //   ""
  // ]

  boot_wait = "3s"

  // http_directory = "./http"


  # This doesn't enable SSH by default
  # iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-desktop-amd64.iso" 
  # look into sha256sums
  # iso_checksum = "sha256:faabcf33ae53976d2b8207a001ff32f4e5daae013505ac7188c9ea63988f8328"

  iso_url      = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_timeout      = "20m"
  ssh_port         = 22
  ssh_username     = var.username
  ssh_password     = var.password
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

  //   guest_additions_path = "VBoxGuestAdditions_8.0.26.iso"
  vm_name = "${var.vm_name}"
}

build {
  sources = ["sources.virtualbox-iso.ubuntu-noble-amd64"]

  # Post Installation VM Tools Configuration
  provisioner "shell" {
    inline = [
      # Wait for cloud-init to complete
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      # Configure VMware tools and clean up
      # ...
    ]
  }

  # Docker Installation
  provisioner "shell" {
    inline = [
      "echo 'Install Docker...'"
      # Docker Install commands
    ]
  }
}
source "virtualbox-iso" "ubuntu-noble-amd64" {
  guest_os_type = "Ubuntu_64"

  cpus      = var.cpus
  memory    = var.memory
  disk_size = var.disk_size
  // hard_drive_interface = "sata"
  // iso_interface = "sata"

  headless = var.headless

  iso_url      = var.iso_url
  iso_checksum = var.iso_checksum

  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--vram", "32"],
    ["modifyvm", "{{.Name}}", "--clipboard", "bidirectional"],
    ["modifyvm", "{{.Name}}", "--draganddrop", "bidirectional"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]

  http_directory = "http"
  boot_wait      = "5s"

  boot_command = [
    "<esc><wait>",
    "linux /casper/vmlinuz ",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    " --- <enter><wait>",
    "initrd /casper/initrd<enter>"
  ]

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

  # cleanup and optimize
  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S bash '{{ .Path }}'"
    script          = "scripts/cleanup.sh"
  }

  # Export as Vagrant box
  post-processor "vagrant" {
    keep_input_artifact = false
    output = "builds/{{.Provider}}-${var.vm_name}.box"
    compression_level = 9
  }

}
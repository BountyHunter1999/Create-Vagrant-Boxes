
locals {
    scrpts = [

                "${path.root}/scripts/${var.os_name}/networking_${var.os_name}.sh",
                "${path.root}/scripts/${var.os_name}/networking_${var.os_name}.sh",
                "${path.root}/scripts/${var.os_name}/sudoers_${var.os_name}.sh",
                "${path.root}/scripts/${var.os_name}/systemd_${var.os_name}.sh",
                "${path.root}/scripts/${var.os_name}/hyperv_${var.os_name}.sh",
                "${path.root}/scripts/${var.os_name}/cleanup_${var.os_name}.sh",
                "${path.root}/scripts/_common/parallels_post_cleanup_debian_ubuntu.sh"

    ]
}

build {
  // sources = ["sources.virtualbox-iso.ubuntu-noble-amd64"]
  sources = ["sources.virtualbox-iso.vm"]

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
    output              = "builds/{{.Provider}}-${var.vm_name}.box"
    compression_level   = 9
  }

}
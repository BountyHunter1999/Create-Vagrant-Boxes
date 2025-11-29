build {
  sources = ["source.virtualbox-iso.vm"]

  # Wait for cloud-init to complete
  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 2; done",
      "sleep 5"
    ]
  }

  # Install VirtualBox Guest Additions
  // provisioner "shell" {
  //   execute_command = "echo '{{ user `password` }}' | sudo -S bash '{{ .Path }}'"
  //   script          = "${path.root}/scripts/guest_tools.virtualbox.sh"
  // }

  # Configure networking
  provisioner "shell" {
    execute_command = "echo '{{ user `password` }}' | sudo -S bash '{{ .Path }}'"
    script          = "${path.root}/scripts/ubuntu/networking.sh"
  }

  # Configure sudoers
  provisioner "shell" {
    execute_command = "echo '{{ user `password` }}' | sudo -S bash '{{ .Path }}'"
    script          = "${path.root}/scripts/ubuntu/sudoers.sh"
  }

  # Cleanup and optimize
  provisioner "shell" {
    execute_command = "echo '{{ user `password` }}' | sudo -S bash '{{ .Path }}'"
    script          = "${path.root}/scripts/ubuntu/cleanup.sh"
  }

  # Export as Vagrant box
  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "builds/{{.Provider}}-{{ user `vm_name` }}.box"
    compression_level   = 9
  }
}

  
locals {
  http_directory = "http"
  # virtualbox-iso
  chipset = var.chipset == null ? "ich9" : var.chipset
  # Default values for boot configuration
  default_boot_command = var.is_windows ? [] : ["<wait>e<wait><down><down><down><end> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/<wait><f10><wait>"]
  default_boot_wait    = var.is_windows ? "2m" : "5s"
  # CD/Floppy configuration
  cd_files = var.cd_files
  # Communicator configuration
  communicator = var.is_windows ? "winrm" : "ssh"
  # VM configuration
  disk_size      = var.disk_size
  memory         = var.memory
  vm_name        = var.vm_name
  iso_target_path = null
  # Shutdown configuration
  shutdown_command = var.is_windows ? "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\"" : "echo '${var.password}' | sudo -S shutdown -P now"
  # SSH configuration with defaults
  ssh_username = var.ssh_username != null ? var.ssh_username : var.username
  ssh_password = var.ssh_password != null ? var.ssh_password : var.password
  # WinRM configuration with defaults
  winrm_username = var.winrm_username != null ? var.winrm_username : var.username
  winrm_password = var.winrm_password != null ? var.winrm_password : var.password
  gfx_controller = var.gfx_controller == null ? (
    var.is_windows ? "vboxsvga" : "vboxsvga"
  ) : var.gfx_controller
  gfx_vram_size = var.gfx_controller == null ? (
    var.is_windows ? 128 : 33
  ) : var.gfx_vram_size
  guest_additions_mode = var.guest_additions_mode == null ? (
    var.is_windows ? "attach" : "upload"
  ) : var.guest_additions_mode
  hard_drive_interface = var.hard_drive_interface == null ? (
    var.is_windows ? "sata" : "virtio"
  ) : var.hard_drive_interface
  iso_interface = var.iso_interface == null ? (
    var.is_windows ? "sata" : "virtio"
  ) : var.iso_interface
  vboxmanage = var.vboxmanage == null ? (
    var.is_windows ? (
      var.os_arch == "aarch64" ? [
        ["modifyvm", "{{.Name}}", "--chipset", "armv8virtual"],
        ["modifyvm", "{{.Name}}", "--audio-enabled", "off"],
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
        ["modifyvm", "{{.Name}}", "--cableconnected1", "on"],
        ["modifyvm", "{{.Name}}", "--usb-xhci", "on"],
        ["modifyvm", "{{.Name}}", "--mouse", "usb"],
        ["modifyvm", "{{.Name}}", "--keyboard", "usb"],
        ["modifyvm", "{{.Name}}", "--nic-type1", "usbnet"],
        ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
        ] : [
        ["modifyvm", "{{.Name}}", "--audio-enabled", "off"],
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
        ["modifyvm", "{{.Name}}", "--cableconnected1", "on"],
        ["modifyvm", "{{.Name}}", "--usb-xhci", "on"],
        ["modifyvm", "{{.Name}}", "--mouse", "usb"],
        ["modifyvm", "{{.Name}}", "--keyboard", "usb"],
        ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
      ]
      ) : (
      var.os_arch == "aarch64" ? [
        ["modifyvm", "{{.Name}}", "--chipset", "armv8virtual"],
        ["modifyvm", "{{.Name}}", "--audio-enabled", "off"],
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
        ["modifyvm", "{{.Name}}", "--cableconnected1", "on"],
        ["modifyvm", "{{.Name}}", "--usb-xhci", "on"],
        ["modifyvm", "{{.Name}}", "--graphicscontroller", "qemuramfb"],
        ["modifyvm", "{{.Name}}", "--mouse", "usb"],
        ["modifyvm", "{{.Name}}", "--keyboard", "usb"],
        ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
        ] : [
        ["modifyvm", "{{.Name}}", "--audio-enabled", "off"],
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
        ["modifyvm", "{{.Name}}", "--cableconnected1", "on"],
        ["modifyvm", "{{.Name}}", "--usb-xhci", "on"],
        ["modifyvm", "{{.Name}}", "--mouse", "usb"],
        ["modifyvm", "{{.Name}}", "--keyboard", "usb"],
        ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
      ]
    )
  ) : var.vboxmanage
  nic_type = var.nic_type == null ? (
    var.os_name == "freebsd" ? "82545EM" : null
  ) : var.nic_type
}

source "virtualbox-iso" "vm" {
  # Virtualbox specific options
  chipset                   = local.chipset
  firmware                  = var.firmware
  gfx_accelerate_3d         = var.gfx_accelerate_3d
  gfx_controller            = local.gfx_controller
  gfx_vram_size             = local.gfx_vram_size
  guest_additions_path      = var.guest_additions_path
  guest_additions_mode      = local.guest_additions_mode
  guest_additions_interface = var.guest_additions_interface
  guest_os_type             = var.guest_os_type
  hard_drive_interface      = local.hard_drive_interface
  iso_interface             = local.iso_interface
  nested_virt               = var.nested_virt
  nic_type                  = local.nic_type
  rtc_time_base             = var.rtc_time_base
  usb                       = var.usb
  vboxmanage                = local.vboxmanage
  virtualbox_version_file   = var.virtualbox_version_file
  # Source block common options
  boot_command     = var.boot_command == null ? local.default_boot_command : var.boot_command
  boot_wait        = var.boot_wait == null ? local.default_boot_wait : var.boot_wait
  cd_content       = var.cd_content
  cd_files         = local.cd_files
  cd_label         = var.cd_label
  cpus             = var.cpus
  communicator     = local.communicator
  disk_size        = local.disk_size
  floppy_files     = var.floppy_files
  headless         = var.headless
  http_directory   = local.http_directory
  iso_checksum     = var.iso_checksum
  iso_target_path  = local.iso_target_path
  iso_url          = var.iso_url
  memory           = local.memory
  // output_directory = "${local.output_directory}-virtualbox"
  shutdown_command = local.shutdown_command
  shutdown_timeout = var.shutdown_timeout
  ssh_password     = local.ssh_password
  ssh_port         = var.ssh_port
  ssh_timeout      = var.ssh_timeout
  ssh_username     = local.ssh_username
  vm_name          = local.vm_name
}

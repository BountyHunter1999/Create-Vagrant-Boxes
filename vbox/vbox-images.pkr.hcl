locals {
  http_directory = "http"
  
  # VirtualBox specific defaults
  chipset = var.chipset == null ? "ich9" : var.chipset
  
  # Boot configuration
  default_boot_command = var.boot_command
  default_boot_wait    = var.boot_wait
  
  # Communicator configuration
  communicator = "ssh"
  
  # VM configuration
  disk_size      = var.disk_size
  memory         = var.memory
  vm_name        = var.vm_name
  iso_target_path = null
  
  # Shutdown configuration
  shutdown_command = "echo '${var.password}' | sudo -S shutdown -P now"
  
  # SSH configuration with defaults
  ssh_username = var.ssh_username != null ? var.ssh_username : var.username
  ssh_password = var.ssh_password != null ? var.ssh_password : var.password
  
  # Graphics configuration
  gfx_controller = var.gfx_controller == null ? "vboxsvga" : var.gfx_controller
  gfx_vram_size  = var.gfx_vram_size == null ? 33 : var.gfx_vram_size
  
  # Guest additions configuration
  guest_additions_mode = var.guest_additions_mode == null ? "upload" : var.guest_additions_mode
  
  # Storage interface configuration
  hard_drive_interface = var.hard_drive_interface == null ? "virtio" : var.hard_drive_interface
  iso_interface        = var.iso_interface == null ? "virtio" : var.iso_interface
  
  # VBoxManage commands for Ubuntu
  vboxmanage = var.vboxmanage == null ? [
    ["modifyvm", "{{.Name}}", "--audio-enabled", "off"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{.Name}}", "--cableconnected1", "on"],
    ["modifyvm", "{{.Name}}", "--usb-xhci", "on"],
    ["modifyvm", "{{.Name}}", "--mouse", "usb"],
    ["modifyvm", "{{.Name}}", "--keyboard", "usb"],
    ["storagectl", "{{.Name}}", "--name", "IDE Controller", "--remove"],
  ] : var.vboxmanage
  
  # NIC type
  nic_type = var.nic_type == null ? null : var.nic_type
}

source "virtualbox-iso" "vm" {
  # VirtualBox specific options
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
  boot_command     = local.default_boot_command
  boot_wait        = local.default_boot_wait
  cd_content       = var.cd_content
  cd_files         = var.cd_files
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
  shutdown_command = local.shutdown_command
  shutdown_timeout = var.shutdown_timeout
  ssh_password     = local.ssh_password
  ssh_port         = var.ssh_port
  ssh_timeout      = var.ssh_timeout
  ssh_username     = local.ssh_username
  vm_name          = local.vm_name
}

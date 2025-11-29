variable "username" {
  type        = string
  description = "The username for authentication"
  default     = "vagrant"
}

variable "password" {
  type        = string
  description = "The plaintext password for authentication"
  sensitive   = true
  default     = "vagrant"
}

variable "iso_url" {
  type        = string
  description = "The url to retrieve the ISO image"
  default     = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-live-server-amd64.iso"
}

variable "iso_checksum" {
  type        = string
  description = "The checksum of the ISO image"
  default     = "file:https://releases.ubuntu.com/noble/SHA256SUMS"
}

variable "vm_name" {
  type        = string
  description = "Name of the VM"
  default     = "ubuntu-24.04"
}

variable "cpus" {
  type        = number
  description = "Number of CPUs"
  default     = 2
}

variable "memory" {
  type        = number
  description = "Memory in MB"
  default     = 4096
}

variable "disk_size" {
  type        = string
  description = "Disk size in MB"
  default     = "40000"
}

variable "headless" {
  type        = bool
  description = "Run in headless mode"
  default     = false
}

variable "boot_command" {
  type        = list(string)
  description = "The boot command to use for the VM"
  default     = ["<wait>e<wait><down><down><down><end> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/<wait><f10><wait>"]
}

variable "boot_wait" {
  type        = string
  description = "Time to wait before boot command"
  default     = "5s"
}

variable "shutdown_timeout" {
  type        = string
  description = "The amount of time to wait after executing the shutdown_command"
  default     = "5m"
}

variable "ssh_username" {
  type        = string
  description = "The username for SSH authentication"
  default     = "vagrant"
}

variable "ssh_password" {
  type        = string
  description = "The plaintext password for SSH authentication"
  sensitive   = true
  default     = "vagrant"
}

variable "ssh_port" {
  type        = number
  description = "The port that SSH will be available on"
  default     = 22
}

variable "ssh_timeout" {
  type        = string
  description = "The time to wait for SSH to become available"
  default     = "30m"
}

# VirtualBox specific variables
variable "chipset" {
  type        = string
  description = "VirtualBox chipset type"
  default     = null
}

variable "firmware" {
  type        = string
  description = "Firmware type, takes bios or efi"
  default     = "efi"
}

variable "gfx_controller" {
  type        = string
  description = "Graphics controller"
  default     = null
}

variable "gfx_vram_size" {
  type        = number
  description = "Graphics VRAM size in MB"
  default     = null
}

variable "guest_additions_mode" {
  type        = string
  description = "Guest additions installation mode"
  default     = null
}

variable "guest_additions_path" {
  type        = string
  description = "Path to guest additions ISO"
  default     = "VBoxGuestAdditions_{{ .Version }}.iso"
}

variable "guest_additions_interface" {
  type        = string
  description = "Guest additions interface"
  default     = null
}

variable "guest_os_type" {
  type        = string
  description = "OS type for virtualization optimization"
  default     = "Ubuntu_64"
}

variable "hard_drive_interface" {
  type        = string
  description = "Hard drive interface type"
  default     = null
}

variable "iso_interface" {
  type        = string
  description = "ISO interface type"
  default     = null
}

variable "nic_type" {
  type        = string
  description = "NIC type"
  default     = null
}

variable "vboxmanage" {
  type        = list(list(string))
  description = "Custom VBoxManage commands"
  default     = null
}

variable "virtualbox_version_file" {
  type        = string
  description = "VirtualBox version file"
  default     = ".version"
}

variable "rtc_time_base" {
  type        = string
  description = "RTC time base"
  default     = "UTC"
}

variable "usb" {
  type        = bool
  description = "Enable USB support"
  default     = false
}

variable "gfx_accelerate_3d" {
  type        = bool
  description = "Enable 3D acceleration"
  default     = null
}

variable "nested_virt" {
  type        = bool
  description = "Enable nested virtualization"
  default     = null
}

variable "cd_content" {
  type        = map(string)
  description = "Key-Value pairs of files to write to a CD"
  default     = null
}

variable "cd_files" {
  type        = list(string)
  description = "List of files to write to a CD"
  default     = null
}

variable "cd_label" {
  type        = string
  description = "CD label"
  default     = null
}

variable "floppy_files" {
  type        = list(string)
  description = "List of files to write to a floppy disk"
  default     = null
}

variable "os_name" {
  type        = string
  description = "OS Brand Name"
}

variable "os_version" {
  type        = string
  description = "OS version number"
}

variable "os_arch" {
  type = string
  validation {
    condition     = var.os_arch == "x86_64" || var.os_arch == "aarch64"
    error_message = "The OS architecture type should be either x86_64 or aarch64."
  }
  description = "OS architecture type, x86_64 or aarch64"
}

variable "username" {
  type        = string
  description = "The username for authentication"
  default     = "packer"
}

variable "password" {
  type        = string
  description = "The plaintext password for authentication"
  sensitive   = true
  default     = "packer"
}

variable "iso_url" {
  type        = string
  description = "The url to retrieve the ISO image"
  default     = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-live-server-amd64.iso"
}

// https://releases.ubuntu.com/noble/SHA256SUMS
variable "iso_checksum" {
  type        = string
  description = "The checksum of the ISO image"
  default     = "sha256:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
}


variable "vm_name" {
  type    = string
  default = "ubuntu-latest"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "disk_size" {
  type    = string
  default = "40000"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "boot_command" {
  type = list(string)
  description = "The boot command to use for the VM"
  default = ["<wait>e<wait><down><down><down><end> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/<wait><f10><wait>"]
}




// 

# virtualbox-iso
variable "is_windows" {
  type = bool
  description = "Whether the VM is running on Windows"
  default = false
}

variable "boot_wait" {
  type    = string
  default = null
}
variable "chipset" {
  type    = string
  default = null
}
variable "firmware" {
  type        = string
  default     = "efi"
  description = "Firmware type, takes bios or efi"
}
variable "gfx_accelerate_3d" {
  type    = bool
  default = null
}
variable "gfx_controller" {
  type    = string
  default = null
}
variable "gfx_vram_size" {
  type    = number
  default = null
}
variable "guest_additions_interface" {
  type    = string
  default = null
}
variable "guest_additions_mode" {
  type    = string
  default = null
}
variable "guest_additions_path" {
  type    = string
  default = "VBoxGuestAdditions_{{ .Version }}.iso"
}
variable "guest_os_type" {
  type        = string
  default     = null
  description = "OS type for virtualization optimization"
}
variable "hard_drive_interface" {
  type    = string
  default = null
}
variable "iso_interface" {
  type    = string
  default = null
}
variable "vboxmanage" {
  type    = list(list(string))
  default = null
}
variable "nested_virt" {
  type    = bool
  default = null
}
variable "nic_type" {
  type    = string
  default = null
}
variable "virtualbox_version_file" {
  type    = string
  default = ".version"
}
variable "rtc_time_base" {
  type        = string
  default     = "UTC"
  description = "RTC time base"
}
variable "usb" {
  type    = bool
  default = false
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

variable "shutdown_timeout" {
  type        = string
  description = "The amount of time to wait after executing the shutdown_command"
  default     = "5m"
}

variable "ssh_password" {
  type        = string
  description = "The plaintext password for SSH authentication"
  sensitive   = true
  default     = vagrant
}

variable "ssh_port" {
  type        = number
  description = "The port that SSH will be available on"
  default     = 22
}

variable "ssh_timeout" {
  type        = string
  description = "The time to wait for SSH to become available"
  default     = "20m"
}

variable "ssh_username" {
  type        = string
  description = "The username for SSH authentication"
  default     = null
}

variable "winrm_password" {
  type        = string
  description = "The plaintext password for WinRM authentication"
  sensitive   = true
  default     = null
}

variable "winrm_timeout" {
  type        = string
  description = "The amount of time to wait for WinRM to become available"
  default     = "30m"
}

variable "winrm_username" {
  type        = string
  description = "The username for WinRM authentication"
  default     = null
}
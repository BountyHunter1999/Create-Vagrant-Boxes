variable "vm_name" {
  type    = string
  default = "my-vm"
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
  default = "packer123"
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
### ssh settings

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

variable "vms_ssh_user" {
  type        = string
  default     = "ubuntu"
  description = "ssh <vms_ssh_user>@any-ip"
}
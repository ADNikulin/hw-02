### common
variable "vm_web_family_os_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "family os name"
}

### vm settings 

# variable "vm_web_platform_settings" {
#   type = object({
#     core_count = number
#     memory_count = number
#     core_fraction = number
#     preemptible = bool
#     platform_id = string
#   })
#   default = {
#     core_count = 2
#     core_fraction = 20
#     memory_count = 2
#     preemptible = true
#     platform_id = "standard-v3"
#   }
#   description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
# }

variable "vm_web_nat_is_enable" {
  type    = bool
  default = false
}

variable "vm_web_name" {
  type        = string
  default     = "web"
  description = "vm name name"
}

### db vm settings
# variable "vm_db_platform_settings" {
#   type = object({
#     core_count = number
#     memory_count = number
#     core_fraction = number
#     preemptible = bool
#     platform_id = string
#   })
#   default = {
#     core_count = 2
#     core_fraction = 20
#     memory_count = 4
#     preemptible = true
#     platform_id = "standard-v3"
#   }
#   description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
# }

variable "vm_db_name" {
  type        = string
  default     = "db"
  description = "vm db name name"
}

variable "vm_db_nat_is_enable" {
  type    = bool
  default = false
}

variable "vm_resources" {
  type = map(object({
    core_count    = number
    memory_count  = number
    core_fraction = number
    preemptible   = bool
    platform_id   = string
    hdd_size      = number
    hdd_type      = string
  }))
  description = "resources for vm"
  default = {
    "web" = {
      core_count    = 2
      core_fraction = 20
      memory_count  = 2
      preemptible   = true
      platform_id   = "standard-v3"
      hdd_size      = 5
      hdd_type      = "network-hdd"
    },
    "db" = {
      core_count    = 2
      core_fraction = 20
      memory_count  = 4
      preemptible   = true
      platform_id   = "standard-v3"
      hdd_size      = 5
      hdd_type      = "network-hdd"
    }
  }
}

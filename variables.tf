###cloud vars
variable "zones" {
  type        = object({
    ru_central1_a = string,
    ru_central1_b = string,
    ru_central1_c = string,
    ru_central1_d = string,
  })
  description = "https://yandex.cloud/ru/docs/overview/concepts/geo-scope"
  default = {
    ru_central1_a = "ru-central1-a",
    ru_central1_b = "ru-central1-b",
    ru_central1_c = "ru-central1-c",
    ru_central1_d = "ru-central1-d"
  }
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "path_to_authorized_keys" {
  type        = string
  description = "path to file keys; https://yandex.cloud/en/docs/iam/concepts/authorization/key"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}
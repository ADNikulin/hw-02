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
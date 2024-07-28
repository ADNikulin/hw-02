locals {
    name-web = "netology-${var.zones.ru_central1_a}-${var.vpc_name}-platform-${var.vm_web_name}"
    name-db = "netology-${var.zones.ru_central1_b}-${var.vpc_name}-platform-${var.vm_db_name}"
}

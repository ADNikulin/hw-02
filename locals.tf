locals {
  name-web          = "netology-${var.zones.ru_central1_a}-${var.vpc_name}-platform-${var.vm_web_name}"
  name-db           = "netology-${var.zones.ru_central1_b}-${var.vpc_name}-platform-${var.vm_db_name}"
  vpc_subnet_name_a = "${var.vpc_name}-a"
  vpc_subnet_name_b = "${var.vpc_name}-b"

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vms_ssh_user}:${var.vms_ssh_root_key}"
  }
}

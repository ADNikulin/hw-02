resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop_a" {
  name           = "${var.vpc_name}-a"
  zone           = var.zones.ru_central1_a
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_a
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-b"
  zone           = var.zones.ru_central1_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family_os_name
}

resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_settings.platform_id
  zone        = var.zones.ru_central1_a
  
  resources {
    cores         = var.vm_web_platform_settings.core_count
    memory        = var.vm_web_platform_settings.memory_count
    core_fraction = var.vm_web_platform_settings.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_platform_settings.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = var.vm_web_nat_is_enable
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vms_ssh_user}:${var.vms_ssh_root_key}"
  }

}

resource "yandex_compute_instance" "platform_db" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_settings.platform_id
  zone        = var.zones.ru_central1_b
  
  resources {
    cores         = var.vm_db_platform_settings.core_count
    memory        = var.vm_db_platform_settings.memory_count
    core_fraction = var.vm_db_platform_settings.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_platform_settings.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vm_db_nat_is_enable
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vms_ssh_user}:${var.vms_ssh_root_key}"
  }

}
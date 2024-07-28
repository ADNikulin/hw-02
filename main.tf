resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop_a" {
  name           = local.vpc_subnet_name_a
  zone           = var.zones.ru_central1_a
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_a
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = local.vpc_subnet_name_b
  zone           = var.zones.ru_central1_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family_os_name
}

resource "yandex_compute_instance" "platform" {
  name        = local.name-web
  platform_id = var.vm_resources.web.platform_id
  zone        = var.zones.ru_central1_a
  
  resources {
    cores         = var.vm_resources.web.core_count
    memory        = var.vm_resources.web.memory_count
    core_fraction = var.vm_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vm_resources.web.hdd_size
      type = var.vm_resources.web.hdd_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_resources.web.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = var.vm_web_nat_is_enable
  }

  metadata = local.metadata

}

resource "yandex_compute_instance" "platform_db" {
  name        = local.name-db
  platform_id = var.vm_resources.db.platform_id
  zone        = var.zones.ru_central1_b
  
  resources {
    cores         = var.vm_resources.db.core_count
    memory        = var.vm_resources.db.memory_count
    core_fraction = var.vm_resources.db.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vm_resources.db.hdd_size
      type = var.vm_resources.db.hdd_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_resources.db.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vm_db_nat_is_enable
  }

  metadata = local.metadata

}
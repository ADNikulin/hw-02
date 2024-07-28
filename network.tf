resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop_a" {
  name           = local.vpc_subnet_name_a
  zone           = var.zones.ru_central1_a
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_a
  route_table_id = yandex_vpc_route_table.route_table.id
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = local.vpc_subnet_name_b
  zone           = var.zones.ru_central1_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_b
  route_table_id = yandex_vpc_route_table.route_table.id
}
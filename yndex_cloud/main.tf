terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state-bucket-mentor"
    region     = "ru-central1-a"
    key        = "issue1/lemp.tfstate"
    access_key = "YCAJEXUIA2C7m0vBy-DGK_GM4"
    secret_key = "YCNoc7kDI7qz8PPUF6NxldimwiQEZlsBgF7F5VmW"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
provider "yandex" {
  token     = "y0_AgAAAABkpk0NAATuwQAAAADSwkfOmQ835bV7TKqjVbXe1ht1599AzVs"
  cloud_id  = "b1gfqsibs2oth9v8tqp5"
  folder_id = "b1gt036erts2va4jvqeq"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}


module "ya_instance_1" {
  source                = "./modules/instance"
  instance_family_image = "lemp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id

}

module "ya_instance_2" {
  source                = "./modules/instance"
  instance_family_image = "lamp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet2.id
}




#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#      version = "0.60.0"
#    }
#  }
#}
#provider "yandex" {
#  token     = "y0_AgAAAABkpk0NAATuwQAAAADSwkfOmQ835bV7TKqjVbXe1ht1599AzVs"
#  cloud_id  = "b1gfqsibs2oth9v8tqp5"
#  folder_id = "b1gt036erts2va4jvqeq"
#  zone      = "ru-central1-a"
#}
#
#data "yandex_compute_image" "my_image" {
#  family = "lemp"
#}
#
#resource "yandex_compute_instance" "vm-1" {
#  name = "terraform1"
#
#  resources {
#    cores  = 2
#    memory = 2
#  }
#
#  boot_disk {
#    initialize_params {
#      image_id = data.yandex_compute_image.my_image.id
#    }
#  }
#
#  network_interface {
#    subnet_id = yandex_vpc_subnet.subnet-1.id
#    nat       = true
#  }
#
#  metadata = {
#    ssh-keys = "ubuntu:${file("C:\\Users\\User\\.ssh/id_ed25519.pub")}"
#  }
#}
#
#resource "yandex_vpc_network" "network-yandex" {
#  name = "network1"
#}
#
#resource "yandex_vpc_subnet" "subnet-1" {
#  name           = "subnet1"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.network-yandex.id
#  v4_cidr_blocks = ["192.168.10.0/24"]
#}
#
#output "internal_ip_address_vm_1" {
#  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
#}
#
#output "external_ip_address_vm_1" {
#  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
#}
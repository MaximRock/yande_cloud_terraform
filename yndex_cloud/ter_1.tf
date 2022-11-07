#variable "zone" {                                # Используем переменную для передачи в конфиг инфраструктуры
#  description = "Use specific availability zone" # Опционально описание переменной
#  type        = string                           # Опционально тип переменной
#  default     = "ru-central1-a"                  # Опционально значение по умолчанию для переменной
#}
#
#terraform {
#  required_providers {
#    yandex = {
#      source  = "yandex-cloud/yandex"
#      version = "0.60.0" # Фиксируем версию провайдера
#    }
#  }
#}
#
## Документация к провайдеру тут https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs#configuration-reference
## Настраиваем the Yandex.Cloud provider
#provider "yandex" {
#  service_account_key_file = file("~/.sa.json")
#  cloud_id                 = "b1gfqsibs2oth9v8tqp5"
#  folder_id                = "b1gt036erts2va4jvqeq"
#  zone                     = var.zone # зона, которая будет использована по умолчанию
#}
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}

provider "random" {
  # Configuration options
}

variable "env" {
  type = string
  validation {
    condition = contains(["prod", "dev"], var.env)
    error_message = "Must be either 'prod' or 'dev'"
  }
}

resource "random_string" "vm_name" {
  length           = 8
  special          = true
  override_special = "/@£$"
  upper            = true
  lower            = false
}

output "vm_name" {
  value = join("-", [random_string.vm_name.result, var.env])
}
# restrict-vm-size
# Source: policies/azure/restrict-vm-size.sentinel
# Conversion quality: Perfect

input "allowed_sizes" {
  type = list(string)
  default = [
    "Standard_A1_v2", "Standard_A2_v2", "Standard_A4_v2",
    "Standard_B1ls", "Standard_B1s", "Standard_B1ms", "Standard_B2s", "Standard_B2ms", "Standard_B4ms",
    "Standard_D1_v2", "Standard_D2_v2", "Standard_D3_v2"
  ]
}

resource_policy "azurerm_virtual_machine" "restrict_vm_size" {
  locals {
    vm_size          = core::try(attrs.vm_size, "")
    vm_size_approved = local.vm_size != "" && core::contains(input.allowed_sizes, local.vm_size)
  }

  enforce {
    condition     = local.vm_size_approved
    error_message = "Virtual machine size '${local.vm_size}' is not approved."
  }
}

resource_policy "azurerm_windows_virtual_machine" "restrict_vm_size" {
  locals {
    vm_size          = core::try(attrs.size, "")
    vm_size_approved = local.vm_size != "" && core::contains(input.allowed_sizes, local.vm_size)
  }

  enforce {
    condition     = local.vm_size_approved
    error_message = "Windows virtual machine size '${local.vm_size}' is not approved."
  }
}

resource_policy "azurerm_linux_virtual_machine" "restrict_vm_size" {
  locals {
    vm_size          = core::try(attrs.size, "")
    vm_size_approved = local.vm_size != "" && core::contains(input.allowed_sizes, local.vm_size)
  }

  enforce {
    condition     = local.vm_size_approved
    error_message = "Linux virtual machine size '${local.vm_size}' is not approved."
  }
}

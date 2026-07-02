# Tests for restrict-vm-size.policy.hcl
# Default input: allowed_sizes = [Standard_A1_v2, Standard_A2_v2, Standard_A4_v2,
#   Standard_B1ls, Standard_B1s, Standard_B1ms, Standard_B2s, Standard_B2ms, Standard_B4ms,
#   Standard_D1_v2, Standard_D2_v2, Standard_D3_v2]
#
# Three resource types are covered in one policy file:
#   azurerm_virtual_machine  → attrs.vm_size
#   azurerm_windows_virtual_machine → attrs.size
#   azurerm_linux_virtual_machine   → attrs.size

policytest {
  targets = ["restrict-vm-size.policy.hcl"]
}

# =========================================================
# azurerm_virtual_machine (uses attrs.vm_size)
# =========================================================

# --- PASSING cases ---

resource "azurerm_virtual_machine" "approved_size_passes" {
  attrs = {
    vm_size = "Standard_B2s"
  }
}

# --- FAILING cases ---

resource "azurerm_virtual_machine" "unapproved_size_fails" {
  expect_failure = true
  attrs = {
    vm_size = "Standard_Z99"
  }
}

# Empty string: core::try returns "", "" != "" is false → vm_size_approved = false
resource "azurerm_virtual_machine" "empty_vm_size_fails" {
  expect_failure = true
  attrs = {
    vm_size = ""
  }
}

# Missing attribute: core::try(attrs.vm_size, "") catches error, returns "" → fails
resource "azurerm_virtual_machine" "missing_vm_size_fails" {
  expect_failure = true
  attrs = {}
}

# =========================================================
# azurerm_windows_virtual_machine (uses attrs.size)
# =========================================================

# --- PASSING cases ---

resource "azurerm_windows_virtual_machine" "approved_size_passes" {
  attrs = {
    size = "Standard_D2_v2"
  }
}

# --- FAILING cases ---

resource "azurerm_windows_virtual_machine" "unapproved_size_fails" {
  expect_failure = true
  attrs = {
    size = "Standard_Z99"
  }
}

# Empty string
resource "azurerm_windows_virtual_machine" "empty_size_fails" {
  expect_failure = true
  attrs = {
    size = ""
  }
}

# Missing attribute
resource "azurerm_windows_virtual_machine" "missing_size_fails" {
  expect_failure = true
  attrs = {}
}

# =========================================================
# azurerm_linux_virtual_machine (uses attrs.size)
# =========================================================

# --- PASSING cases ---

resource "azurerm_linux_virtual_machine" "approved_size_passes" {
  attrs = {
    size = "Standard_A2_v2"
  }
}

# --- FAILING cases ---

resource "azurerm_linux_virtual_machine" "unapproved_size_fails" {
  expect_failure = true
  attrs = {
    size = "Standard_Z99"
  }
}

# Empty string
resource "azurerm_linux_virtual_machine" "empty_size_fails" {
  expect_failure = true
  attrs = {
    size = ""
  }
}

# Missing attribute
resource "azurerm_linux_virtual_machine" "missing_size_fails" {
  expect_failure = true
  attrs = {}
}

# Tests for restrict-vm-size.policy.hcl
# Custom input: allowed_sizes = ["Standard_B1s"]
#
# Demonstrates that restricting the allow-list to a single size causes sizes that
# were previously approved (e.g. Standard_B2s) to fail, while Standard_B1s still passes.

policytest {
  targets = ["restrict-vm-size.policy.hcl"]
}

inputs {
  allowed_sizes = ["Standard_B1s"]
}

# --- PASSING cases ---

# Standard_B1s is the only allowed size under this custom list
resource "azurerm_virtual_machine" "b1s_passes" {
  attrs = {
    vm_size = "Standard_B1s"
  }
}

resource "azurerm_linux_virtual_machine" "b1s_passes" {
  attrs = {
    size = "Standard_B1s"
  }
}

# --- FAILING cases ---

# Standard_B2s was in the default list but is excluded from this custom list
resource "azurerm_virtual_machine" "b2s_no_longer_allowed_fails" {
  expect_failure = true
  attrs = {
    vm_size = "Standard_B2s"
  }
}

resource "azurerm_windows_virtual_machine" "d2v2_not_in_custom_list_fails" {
  expect_failure = true
  attrs = {
    size = "Standard_D2_v2"
  }
}

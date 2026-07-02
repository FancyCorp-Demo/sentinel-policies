# Tests for limit-proposed-monthly-cost.policy.hcl
#
# This policy is a stub: it uses a provider_policy "*" with condition = true
# because tfpolicy does not expose run-level cost estimate signals.
# The condition always evaluates to true, so no provider mock can trigger a failure.
# This test file exists to confirm the stub evaluates without errors.

policytest {
  targets = ["limit-proposed-monthly-cost.policy.hcl"]
}

# Any provider passes — condition = true regardless of provider type or source
provider "aws" "stub_always_passes" {
  meta = {
    source = "registry.terraform.io/hashicorp/aws"
  }
}

provider "azurerm" "stub_always_passes" {
  meta = {
    source = "registry.terraform.io/hashicorp/azurerm"
  }
}

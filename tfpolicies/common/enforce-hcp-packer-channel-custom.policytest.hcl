# Tests for enforce-hcp-packer-channel.policy.hcl
# Custom input: expected_channel = "staging"
#
# Demonstrates that the same channel values swap pass/fail when the expected
# channel is overridden: "staging" now passes, "production" now fails.

policytest {
  targets = ["enforce-hcp-packer-channel.policy.hcl"]
}

inputs {
  expected_channel = "staging"
}

# --- PASSING cases ---

# "staging" is the expected channel under this custom configuration
resource "hcp_packer_iteration" "staging_channel_passes" {
  attrs = {
    channel = "staging"
  }
}

# --- FAILING cases ---

# "production" was the default expected channel but fails under this custom config
resource "hcp_packer_iteration" "production_channel_now_fails" {
  expect_failure = true
  attrs = {
    channel = "production"
  }
}

# Wrong channel relative to either config
resource "hcp_packer_iteration" "dev_channel_fails" {
  expect_failure = true
  attrs = {
    channel = "dev"
  }
}

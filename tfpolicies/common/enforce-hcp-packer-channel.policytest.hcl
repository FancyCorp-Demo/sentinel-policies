# Tests for enforce-hcp-packer-channel.policy.hcl
# Default input: expected_channel = "production"

policytest {
  targets = ["enforce-hcp-packer-channel.policy.hcl"]
}

# --- PASSING cases ---

resource "hcp_packer_iteration" "production_channel_passes" {
  attrs = {
    channel = "production"
  }
}

# --- FAILING cases ---

# Wrong channel name
resource "hcp_packer_iteration" "staging_channel_fails" {
  expect_failure = true
  attrs = {
    channel = "staging"
  }
}

# Explicit empty string: "" != "" is false → channel_is_valid = false
resource "hcp_packer_iteration" "empty_channel_fails" {
  expect_failure = true
  attrs = {
    channel = ""
  }
}

# Null channel: core::try(null, "") returns null (null is not an error in HCL try);
# null != "" may be true but null == input.expected_channel is false → fails
resource "hcp_packer_iteration" "null_channel_fails" {
  expect_failure = true
  attrs = {
    channel = null
  }
}

# Missing attribute: core::try(attrs.channel, "") catches missing-key error, returns "" → fails
resource "hcp_packer_iteration" "missing_channel_fails" {
  expect_failure = true
  attrs = {}
}

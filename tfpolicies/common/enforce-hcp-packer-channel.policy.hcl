# enforce-hcp-packer-channel
# Source: policies/common/enforce-hcp-packer-channel.sentinel
# Conversion quality: Perfect

input "expected_channel" {
  type    = string
  default = "production"
}

resource_policy "hcp_packer_iteration" "enforce_hcp_packer_channel" {
  locals {
    channel_value    = core::try(attrs.channel, "")
    channel_is_valid = local.channel_value != "" && local.channel_value == input.expected_channel
  }

  enforce {
    condition     = local.channel_is_valid
    error_message = "HCP Packer iteration channel must be '${input.expected_channel}'."
  }
}

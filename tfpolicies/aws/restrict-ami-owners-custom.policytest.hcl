# Tests for restrict-ami-owners.policy.hcl
# Custom input: allowed_owners = ["self", "amazon"]
#
# Demonstrates that "amazon" (an AWS-managed owner) becomes permitted under a custom
# allow-list, while arbitrary account IDs remain blocked.

policytest {
  targets = ["restrict-ami-owners.policy.hcl"]
}

inputs {
  allowed_owners = ["self", "amazon"]
}

# --- PASSING cases ---

# "amazon" is approved under the custom list
resource "aws_ami" "amazon_owner_passes" {
  attrs = {
    owners = ["amazon"]
  }
}

# Both approved owners together
resource "aws_ami" "self_and_amazon_passes" {
  attrs = {
    owners = ["self", "amazon"]
  }
}

# --- FAILING cases ---

# Account ID — not in custom list
resource "aws_ami" "account_id_fails" {
  expect_failure = true
  attrs = {
    owners = ["123456789012"]
  }
}

# Mix of approved and unapproved — any disallowed entry fails
resource "aws_ami" "amazon_plus_account_id_fails" {
  expect_failure = true
  attrs = {
    owners = ["amazon", "123456789012"]
  }
}

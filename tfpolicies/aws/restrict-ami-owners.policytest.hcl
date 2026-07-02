# Tests for restrict-ami-owners.policy.hcl
# Default input: allowed_owners = ["self"]

policytest {
  targets = ["restrict-ami-owners.policy.hcl"]
}

# --- PASSING cases ---

# Only "self" — the default allowed owner
resource "aws_ami" "self_owner_passes" {
  attrs = {
    owners = ["self"]
  }
}

# Empty owners list — no owners to validate, disallowed_owners = [] → condition true.
# NOTE: policy design intentionally allows AMIs with no declared owner.
resource "aws_ami" "empty_owners_passes" {
  attrs = {
    owners = []
  }
}

# Missing owners attribute — core::try(attrs.owners, []) catches missing-key error
# and returns [] → same result as empty list above (passes by policy design)
resource "aws_ami" "missing_owners_passes" {
  attrs = {}
}

# --- FAILING cases ---

# Account ID owner — not in ["self"]
resource "aws_ami" "account_id_fails" {
  expect_failure = true
  attrs = {
    owners = ["123456789012"]
  }
}

# Mixed list: one allowed ("self"), one disallowed — any disallowed entry fails
resource "aws_ami" "mixed_owners_fails" {
  expect_failure = true
  attrs = {
    owners = ["self", "123456789012"]
  }
}

# Null owners — core::try(null, []) returns null; the policy converts null→[] via
# a conditional, so null owners behave identically to an empty list (passes).
resource "aws_ami" "null_owners_treated_as_empty_passes" {
  attrs = {
    owners = null
  }
}

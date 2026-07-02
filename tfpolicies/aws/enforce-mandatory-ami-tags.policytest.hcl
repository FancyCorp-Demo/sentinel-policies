# Tests for enforce-mandatory-ami-tags.policy.hcl
# No inputs — policy checks that tags.Production == "true" (case-insensitive via core::lower)

policytest {
  targets = ["enforce-mandatory-ami-tags.policy.hcl"]
}

# --- PASSING cases ---

# Canonical lowercase value
resource "aws_ami" "production_true_lowercase_passes" {
  attrs = {
    tags = {
      Production = "true"
    }
  }
}

# Mixed-case value — core::lower normalises it to "true"
resource "aws_ami" "production_true_mixed_case_passes" {
  attrs = {
    tags = {
      Production = "True"
    }
  }
}

# --- FAILING cases ---

# Explicitly set to "false"
resource "aws_ami" "production_false_fails" {
  expect_failure = true
  attrs = {
    tags = {
      Production = "false"
    }
  }
}

# Empty tags map — core::try(local.tags.Production, "") returns "" → not "true"
resource "aws_ami" "empty_tags_fails" {
  expect_failure = true
  attrs = {
    tags = {}
  }
}

# Null tags — core::try(null, {}) returns null; core::try(null.Production, "") catches
# the subsequent traversal error and returns "" → not "true"
resource "aws_ami" "null_tags_fails" {
  expect_failure = true
  attrs = {
    tags = null
  }
}

# Missing tags attribute entirely — core::try(attrs.tags, {}) catches the missing-key
# error and returns {} → chain produces "" → not "true"
resource "aws_ami" "missing_tags_fails" {
  expect_failure = true
  attrs = {}
}

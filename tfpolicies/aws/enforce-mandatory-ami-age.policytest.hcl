# Tests for enforce-mandatory-ami-age.policy.hcl
# Default input: max_ami_age_days = 30
#
# Passing mocks use "2099-01-01T00:00:00Z" — attrs blocks are static HCL literals
# so core::timestamp() is not available here. A far-future date always satisfies
# the condition (creation_date > cutoff) without needing periodic updates.

policytest {
  targets = ["enforce-mandatory-ami-age.policy.hcl"]
}

# --- PASSING cases ---

# Far-future date: always satisfies creation_date > cutoff regardless of when tests run
resource "aws_ami" "recent_ami_passes" {
  attrs = {
    creation_date = "2099-01-01T00:00:00Z"
  }
}

# --- FAILING cases ---

# Old AMI: 6 months old, far outside the 30-day limit
resource "aws_ami" "old_ami_fails" {
  expect_failure = true
  attrs = {
    creation_date = "2026-01-01T00:00:00Z"
  }
}

# Explicit empty string: core::try returns "", then "" != "" is false → age_valid = false
resource "aws_ami" "empty_creation_date_fails" {
  expect_failure = true
  attrs = {
    creation_date = ""
  }
}

# Null creation_date: core::try(null, "") returns null (null is not an error in HCL try);
# core::timecmp(null, ...) will then fail — policy correctly rejects this
resource "aws_ami" "null_creation_date_fails" {
  expect_failure = true
  attrs = {
    creation_date = null
  }
}

# Missing attribute: core::try(attrs.creation_date, "") catches the missing-key error
# and returns "" → "" != "" is false → age_valid = false
resource "aws_ami" "missing_creation_date_fails" {
  expect_failure = true
  attrs = {}
}

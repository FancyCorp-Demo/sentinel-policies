# Tests for enforce-mandatory-ami-age.policy.hcl
# Custom input: max_ami_age_days = 5
#
# This file demonstrates that the same creation_date (2026-06-22) that PASSES the
# default 30-day test NOW FAILS under a 5-day limit, and that a far-future date
# passes permanently.
#
# Passing mocks use "2099-01-01T00:00:00Z" — attrs blocks are static HCL literals
# so core::timestamp() is not available here. A far-future date always satisfies
# the condition (creation_date > cutoff) without needing periodic updates.

policytest {
  targets = ["enforce-mandatory-ami-age.policy.hcl"]
}

inputs {
  max_ami_age_days = 5
}

# --- PASSING cases ---

# Far-future date: always satisfies creation_date > cutoff regardless of when tests run
resource "aws_ami" "very_recent_ami_passes" {
  attrs = {
    creation_date = "2099-01-01T00:00:00Z"
  }
}

# --- FAILING cases ---

# 10 days old — passed the default-30-day test but fails the 5-day custom limit
resource "aws_ami" "ten_days_old_now_fails" {
  expect_failure = true
  attrs = {
    creation_date = "2026-06-22T00:00:00Z"
  }
}

# 6 months old — fails under any reasonable limit
resource "aws_ami" "old_ami_fails" {
  expect_failure = true
  attrs = {
    creation_date = "2026-01-01T00:00:00Z"
  }
}

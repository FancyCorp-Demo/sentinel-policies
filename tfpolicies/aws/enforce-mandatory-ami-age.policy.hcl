# ensure-mandatory-ami-age
# Source: policies/aws/enforce-mandatory-ami-age.sentinel
# Conversion quality: Good
# NOTE: This policy evaluates planned aws_ami resources. Sentinel used tfstate, which may include
# resources outside the current plan.
# NOTE: All time comparisons are in UTC.

input "max_ami_age_days" {
  type    = number
  default = 30
}

resource_policy "aws_ami" "mandatory_ami_age" {
  locals {
    creation_date   = core::try(attrs.creation_date, "")
    age_limit_hours = input.max_ami_age_days * 24
    cutoff_date     = core::timeadd(core::timestamp(), "-${local.age_limit_hours}h")
    # core::try wraps the timecmp call because locals{} does not short-circuit &&:
    # an empty or null creation_date would otherwise crash core::timecmp before the
    # != "" guard has a chance to short-circuit.
    age_valid       = core::try(local.creation_date != "" && core::timecmp(local.creation_date, local.cutoff_date) >= 0, false)
  }

  enforce {
    condition     = local.age_valid
    error_message = "AMI creation_date must be within the last ${input.max_ami_age_days} days (UTC)."
  }
}

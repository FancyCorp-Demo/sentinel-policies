# restrict-ami-owners
# Source: policies/aws/restrict-ami-owners.sentinel
# Conversion quality: Good
# NOTE: This conversion enforces that every configured owner is in the approved allowlist.

input "allowed_owners" {
  type    = list(string)
  default = ["self"]
}

resource_policy "aws_ami" "restrict_ami_owners" {
  locals {
    # core::try(null, []) returns null — null is not an error in HCL try.
    # The conditional below converts null to [] so the for-loop is always safe.
    owners_raw         = core::try(attrs.owners, [])
    owners             = local.owners_raw != null ? local.owners_raw : []
    disallowed_owners  = [for owner in local.owners : owner if !core::contains(input.allowed_owners, owner)]
    owners_are_allowed = core::length(local.disallowed_owners) == 0
  }

  enforce {
    condition     = local.owners_are_allowed
    error_message = "AMI owners must be from the approved list: ${core::join(", ", input.allowed_owners)}."
  }
}

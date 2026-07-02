# enforce-mandatory-ami-tags
# Source: policies/aws/enforce-mandatory-ami-tags.sentinel
# Conversion quality: Perfect

resource_policy "aws_ami" "mandatory_production_tag" {
  locals {
    tags             = core::try(attrs.tags, {})
    production_value = core::lower(core::try(local.tags.Production, ""))
    is_prod_approved = local.production_value == "true"
  }

  enforce {
    condition     = local.is_prod_approved
    error_message = "AMI must include tag Production=true before it can be used for production workloads."
  }
}

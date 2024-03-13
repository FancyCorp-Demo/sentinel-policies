#
# Modules
#
#
module "tfplan-functions" {
  source = "../policies/functions/tfplan-functions/tfplan-functions.sentinel"
}

module "tfstate-functions" {
  source = "../policies/functions/tfstate-functions/tfstate-functions.sentinel"
}

module "tfconfig-functions" {
  source = "../policies/functions/tfconfig-functions/tfconfig-functions.sentinel"
}

module "tfrun-functions" {
  source = "../policies/functions/tfrun-functions/tfrun-functions.sentinel"
}

#
# AWS Policies
#

policy "aws/restrict-ami-owners" {
  source            = "../policies/aws/restrict-ami-owners.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "aws/enforce-mandatory-ami-tags" {
  source = "../policies/aws/enforce-mandatory-ami-tags.sentinel"

  # We fully expect the Test env to be using non-Prod AMIs
  # But we want to make sure they're highlighted
  enforcement_level = "advisory"
}

policy "aws/enforce-mandatory-ami-age" {
  source            = "../policies/aws/enforce-mandatory-ami-age.sentinel"
  enforcement_level = "soft-mandatory"
}

#
# Azure Policies
#

policy "azure/restrict-vm-size" {
  source            = "../policies/azure/restrict-vm-size.sentinel"
  enforcement_level = "soft-mandatory"
}

#
# Common Policies
#

policy "common/require-all-modules-from-pmr" {
  source            = "../policies/common/require-all-modules-from-pmr.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "common/limit-proposed-monthly-cost" {
  source            = "../policies/common/limit-proposed-monthly-cost.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "common/enforce-hcp-packer-channel" {
  source = "../policies/common/enforce-hcp-packer-channel.sentinel"

  # We expect that the Test env will use non-prod channels, so this is allowed
  enforcement_level = "advisory"
}


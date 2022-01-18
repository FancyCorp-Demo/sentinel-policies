#
# Modules
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
  enforcement_level = "hard-mandatory"
}

policy "aws/enforce-mandatory-ami-tags" {
  source            = "../policies/aws/enforce-mandatory-ami-tags.sentinel"
  enforcement_level = "hard-mandatory"
}

#
# Azure Policies
#

policy "azure/restrict-vm-size" {
  source            = "../policies/azure/restrict-vm-size.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "azure/restrict-vm-publisher" {
  source            = "../policies/azure/restrict-vm-publisher.sentinel"
  enforcement_level = "hard-mandatory"
}

#
# Common Policies
#

policy "common/require-all-modules-from-pmr" {
  source            = "../policies/common/require-all-modules-from-pmr.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "common/limit-proposed-monthly-cost" {
  source            = "../policies/common/limit-proposed-monthly-cost.sentinel"
  enforcement_level = "hard-mandatory"
}

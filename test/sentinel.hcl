module "tfplan-functions" {
  source = "../policies/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

module "tfstate-functions" {
  source = "../policies/common-functions/tfstate-functions/tfstate-functions.sentinel"
}

module "tfconfig-functions" {
  source = "../policies/common-functions/tfconfig-functions/tfconfig-functions.sentinel"
}

module "tfrun-functions" {
  source = "../policies/common-functions/tfrun-functions/tfrun-functions.sentinel"
}

policy "require-all-modules-from-pmr" {
  source            = "../policies/require-all-modules-from-pmr.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "restrict-ami-owners" {
  source            = "../policies/restrict-ami-owners.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "enforce-mandatory-ami-tags" {
  source = "../policies/enforce-mandatory-ami-tags.sentinel"

  # We fully expect the Test env to be using non-Prod AMIs
  # But we want to make sure they're highlighted
  enforcement_level = "advisory"
}

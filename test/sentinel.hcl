policy "require-all-modules-from-pmr" {
  source            = "./policies/require-all-modules-from-pmr.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "restrict-ami-owners" {
  source            = "./policies/restrict-ami-owners.sentinel"
  enforcement_level = "soft-mandatory"
}

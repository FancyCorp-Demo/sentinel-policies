# require-all-modules-from-pmr
# Source: policies/common/require-all-modules-from-pmr.sentinel
# Conversion quality: Good
# LIMITATION: Sentinel bypassed enforcement for destroy runs via tfrun.is_destroy.
# tfpolicy module policies do not expose equivalent run-level destroy context.

input "address" {
  type    = string
  default = "app.terraform.io"
}

input "organizations" {
  type = list(string)
}

module_policy "*" "require_all_modules_from_pmr" {
  filter = core::try(core::regex("^module\\.[^.]+$", meta.address), null) != null && core::try(meta.source, "") != ""

  locals {
    organization_matches = [for organization in input.organizations : organization if core::startswith(meta.source, "${input.address}/${organization}/")]
    source_is_approved   = core::length(local.organization_matches) > 0
  }

  enforce {
    condition     = local.source_is_approved
    error_message = "Root module source '${meta.source}' must come from ${input.address} and one of the approved organizations: ${core::join(", ", input.organizations)}."
  }
}

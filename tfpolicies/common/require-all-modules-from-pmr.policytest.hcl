# Tests for require-all-modules-from-pmr.policy.hcl
#
# Policy filter evaluates ONLY root-level module calls that have a non-empty source:
#   filter = core::try(core::regex("^module\\.[^.]+$", meta.address), null) != null
#         && core::try(meta.source, "") != ""
#
# REQUIRED: input "organizations" has no default — this inputs block is mandatory.

policytest {
  targets = ["require-all-modules-from-pmr.policy.hcl"]
}

inputs {
  # address default "app.terraform.io" is preserved — only organizations is overridden
  organizations = ["my-org"]
}

# =========================================================
# PASSING — filter matches, source is from an approved org
# =========================================================

# Root-level module from the approved organization on the default registry address
module "app.terraform.io/my-org/vpc/aws" "approved_vpc" {
  meta = {
    source  = "app.terraform.io/my-org/vpc/aws"
    address = "module.vpc"
    version = "1.0.0"
  }
}

# Second approved root module (different name, same org)
module "app.terraform.io/my-org/security-groups/aws" "approved_sg" {
  meta = {
    source  = "app.terraform.io/my-org/security-groups/aws"
    address = "module.sg"
    version = "2.3.1"
  }
}

# =========================================================
# FAILING — filter matches but source is NOT from approved org
# =========================================================

# Root-level module from a different org on the same registry address
module "app.terraform.io/other-org/vpc/aws" "unapproved_org_fails" {
  expect_failure = true
  meta = {
    source  = "app.terraform.io/other-org/vpc/aws"
    address = "module.vpc_other"
    version = "1.0.0"
  }
}

# Root-level module from the public Terraform Registry (not the private registry)
module "registry.terraform.io/hashicorp/vpc/aws" "public_registry_fails" {
  expect_failure = true
  meta = {
    source  = "registry.terraform.io/hashicorp/vpc/aws"
    address = "module.public_vpc"
    version = "5.0.0"
  }
}

# =========================================================
# PASSING (filter bypass) — not evaluated by policy
# =========================================================

# Nested module address does not match ^module\.[^.]+$ — filter excludes it
# even though it comes from an unapproved org
module "app.terraform.io/other-org/subnet/aws" "nested_bypasses_filter" {
  meta = {
    source  = "app.terraform.io/other-org/subnet/aws"
    address = "module.vpc.module.subnet"
    version = "1.0.0"
  }
}

# Root-level module with empty source — second filter clause (meta.source != "")
# is false, so the policy does not evaluate this module
module "" "empty_source_bypasses_filter" {
  meta = {
    source  = ""
    address = "module.local_only"
  }
}

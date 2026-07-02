# limit-proposed-monthly-cost
# Source: policies/common/limit-proposed-monthly-cost.sentinel
# Conversion quality: Not convertible
# LIMITATION: tfpolicy does not expose tfrun proposed monthly cost estimates as policy attributes.
# Keep this control in Sentinel (or an external cost gate) until tfpolicy exposes run-level cost signals.

provider_policy "*" "limit_proposed_monthly_cost_stub" {
  enforce {
    condition    = true
    info_message = "Automated enforcement not available in tfpolicy: proposed monthly cost estimate is not exposed to provider/resource/module policy contexts."
  }
}

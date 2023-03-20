#
# Policies from Public Registry
#

# https://registry.terraform.io/policies/hashicorp/aws-networking-terraform/latest
policy "deny-public-rdp-acl-rules" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/aws-networking-terraform/1.0.2/policy/deny-public-rdp-acl-rules.sentinel?checksum=sha256:b301e80bd612809aeeac263b5d4b5b22b9f84190da67216cc298a96652301086"
  enforcement_level = "advisory"
}

policy "restrict-all-vpc-traffic-acl-rules" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/aws-networking-terraform/1.0.2/policy/restrict-all-vpc-traffic-acl-rules.sentinel?checksum=sha256:b58e49dbd2e4795481c4af970aaf6dc883bdf5b6fb9cb47e331aa44883e8301d"
  enforcement_level = "advisory"
}

policy "deny-public-ssh-acl-rules" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/aws-networking-terraform/1.0.2/policy/deny-public-ssh-acl-rules.sentinel?checksum=sha256:b56a7869c9ddd2bece7de8d251de106e072407207247e6f94e001b6eba22c71b"
  enforcement_level = "advisory"
}


# https://registry.terraform.io/policies/hashicorp/azure-storage-terraform/latest
policy "trusted-microsoft-services-is-enabled" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-storage-terraform/1.0.2/policy/trusted-microsoft-services-is-enabled.sentinel?checksum=sha256:86261b85c18928efb057883767e6057e165f1c06183ceb493d40e9e23fba7783"
  enforcement_level = "advisory"
}

policy "secure-transfer-required-is-enabled" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-storage-terraform/1.0.2/policy/secure-transfer-required-is-enabled.sentinel?checksum=sha256:ef62fd2786ed886809d4c73939a74433ea3b8a55a9a7bd2ea00cb34b6cef376b"
  enforcement_level = "advisory"
}

policy "queue-logging-is-enabled" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-storage-terraform/1.0.2/policy/queue-logging-is-enabled.sentinel?checksum=sha256:f2dda166b789ee8ee44f42080fbc682e0431b34c7ebda2da0d60b49442ebb0b1"
  enforcement_level = "advisory"
}

policy "default-network-access-rule-set-to-deny" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-storage-terraform/1.0.2/policy/default-network-access-rule-set-to-deny.sentinel?checksum=sha256:063091d2d8f9f259dbf70b44ca5a504ce5d8af1775914a2bb17c545c070a5db8"
  enforcement_level = "advisory"
}

policy "blob-public-access-level-set-to-private" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-storage-terraform/1.0.2/policy/blob-public-access-level-set-to-private.sentinel?checksum=sha256:9a99176020132c73392e88347705887045f7e34c9e5e70d991be5967d568ceb0"
  enforcement_level = "advisory"
}

# https://registry.terraform.io/policies/hashicorp/azure-networking-terraform/latest
policy "enforce-network-watcher-flow-log-retention-period" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/enforce-network-watcher-flow-log-retention-period.sentinel?checksum=sha256:9af52ce96a945ad794fbbdafb78cdc5bd4f331b8253ac99f1223703a69edb79d"
  enforcement_level = "advisory"
}

policy "deny-public-ssh-nsg-rules" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/deny-public-ssh-nsg-rules.sentinel?checksum=sha256:75c95bf1d6eb48153cb31f15c49c237bf7829549beebe20effa07bcdd3f3cb74"
  enforcement_level = "advisory"
}

policy "deny-public-rdp-nsg-rules" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/deny-public-rdp-nsg-rules.sentinel?checksum=sha256:b07e2c47e2683c9b89a75f87dd9617806b257a0db7261881efe51ed5d5893357"
  enforcement_level = "advisory"
}

policy "deny-any-sql-database-ingress" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/deny-any-sql-database-ingress.sentinel?checksum=sha256:20ac4cc88299ea14472b8c39f88bf12e488cf348d8f6435a8e0e9fbc398dea47"
  enforcement_level = "advisory"
}

# https://registry.terraform.io/policies/hashicorp/azure-compute-terraform/latest
policy "managed-disk-encryption-is-enabled" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-compute-terraform/1.0.2/policy/managed-disk-encryption-is-enabled.sentinel?checksum=sha256:bb03c0bcc604c7c452e5549c4149eaf3498f9cae3dcaafbec70f38a38ad0f3a6"
  enforcement_level = "advisory"
}

policy "only-approved-extensions-are-installed" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-compute-terraform/1.0.2/policy/only-approved-extensions-are-installed.sentinel?checksum=sha256:2e5c0dcb146824ce6063c8d7453126ab630eb7e9989b16cea7d4cb0d70340802"
  enforcement_level = "advisory"
}

# https://registry.terraform.io/policies/hashicorp/azure-databases-terraform/latest
policy "mysql-enforce-ssl-connection-is-enabled" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-databases-terraform/1.0.2/policy/mysql-enforce-ssl-connection-is-enabled.sentinel?checksum=sha256:eade6e09225503ecf6166f0fcc69454c6cd11894f2b304d080dfa4ef9b6dfe03"
  enforcement_level = "advisory"
}

policy "psql-enforce-ssl-connection-is-enabled" {
  source            = "https://registry.terraform.io/v2/policies/hashicorp/azure-databases-terraform/1.0.2/policy/psql-enforce-ssl-connection-is-enabled.sentinel?checksum=sha256:c8e0599a8351297bd70e844b8e293c4530b65c9d6bc32436867f85979daea295"
  enforcement_level = "advisory"
}

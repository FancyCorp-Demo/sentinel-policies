mock "tfstate/v2" {
  module {
    source = "./mocks/mock-tfstate-fail-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}

mock "tfstate/v2" {
  module {
    source = "./mocks/mock-tfstate-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}

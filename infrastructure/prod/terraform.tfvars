region = "us-east-1"

# ami-web = "ami-04de84d7edcd7e794"

# ami = "ami-0149b2da6ceec4bb0"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

account_no = 987989075366

keypair = "testkey"

tags = {
  Enviroment      = "production"
  Owner-Email     = "micahshallom@gmail.com"
  Managed-By      = "Micah Shallom Bawa"
  Description     = "Balance DevOps Task "
  Billing-Account = "09071111150"
}
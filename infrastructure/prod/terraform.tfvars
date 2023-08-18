region = "us-east-1"

ami-web = "ami-0452268d5d602bb9e"

ami-bastion = "ami-0a00ed4e3f28ff612"

ami-nginx = "ami-07f388eb978507f3f"


vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

account_no = 987989075366

keypair = "balancee"

tags = {
  Enviroment      = "production"
  Owner-Email     = "micahshallom@gmail.com"
  Managed-By      = "Micah Shallom Bawa"
  Description     = "Balance DevOps Task "
  Billing-Account = "09071111150"
}
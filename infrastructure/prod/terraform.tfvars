region = "us-east-1"

ami-web = "ami-02917276f98a4b524"

ami-bastion = "ami-02917276f98a4b524"

ami-nginx = "ami-02917276f98a4b524"


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
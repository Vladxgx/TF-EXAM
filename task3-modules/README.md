# Usage

All changes are done in root main.tf.

To change VPC CIDR:
  vpc_cidr = "x.x.x.x/xx"

To change number of subnets:
  subnet_count = 3
  (Creates 3 public + 3 private subnets with route associations)

To change EC2 instance type:
  instance_type = "tx.whatever"

To enable/disable public IP:
  assign_public_ip = true / false

To change region:
  modify the value of region = var.region
  default is "us-east-1"

To change name prefix:
    modify name_prefix  = "whatever_you_want"

Outputs are exposed from the root module.

    Available outputs after apply:
        public_ip   -> EC2 public IP
        vpc_id      -> VPC ID

    View outputs:
        terraform output

    View specific output:
        terraform output public_ip

And obviously...
Deploy:
  terraform init
  terraform plan
  terraform apply

Destroy:
  terraform destroy

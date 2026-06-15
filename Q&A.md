Section 1: Q&A (20 Questions)
Terraform Fundamentals (5 questions) 
Q: What is Terraform and how does it differ from other IaC tools?
A: Terraform is a tool used to provision and manage infra in a declarative way. You define an infrastructure and TF creates (or updates) resources to match it using a state file.
   It differs from other IaC tools by being multi cloud, allowing the same tool to be used for AWS, Azure, etc. and as opposed to Ansible, it is used to create infrastructure while Ansible is used to configure existing ones (installing packages, edit config files, manage services)
Q: Explain Terraform's declarative nature and state management.
A: Declarative means you define the desired state of infra, and not the steps to create it. Terraform figures out the steps and actions needed to create/change/destroy the described.
   Terraform uses the state file to track resources and compare the current state with the desired config in order to plan and apply only the required changes.
Q: What is the purpose of the Terraform provider?
A: Provider is a plugin that allows TF to interact with a platform’s API (AWS, Azure, etc.). it defines the available resources and data sources, and how to create, update, read and delete them.
   How does Terraform handle dependency resolution?
   TF understands dependencies by building a dependency graph. Resources that depend on each other are created in correct order while independent ones created in parallel. If a dependency is not declared, TF will notify while running plan but may create things in the wrong order. Also, dependencies can be defined manually using depends_on.
Q: What are the key components of a Terraform configuration file?
A: The main components are:
   Terraform block: Settings, version, backend.
   Provider: Cloud, API config.
   Resources: infra objects.
   Data: reading existing resources.
   Vars: variable inputs.
   Output: exposed values like IP addresses of a created instance etc.
   Modules: a package of resources that can be reused with different inputs.
   Locals: define reusable values in a config to avoid repetition and simplify.


State Management & Backend Configuration (3 questions) 
Q: Explain the difference between terraform refresh, terraform plan, and terraform apply.
A: Refresh: updates the state file to match real infra. Doesn’t change infra. Also done as part of plan.
   Plan: compares config with current state and shows what will change. Does not modify infra.
   Apply: executes the planned changes - creates and updates infra and state.
   What is the difference between local and remote backends?
   Local backend is stored on your machine while remote is stored in the cloud (S3) for team collaboration. Remote also supports state locking (dynamoDB).
Q: How can you prevent state corruption when multiple engineers work on the same infrastructure?
A: By using remote backend with state locking, avoid manual changes, and run one apply at a time.

Terraform Modules & Reusability (4 questions) 
Q: What are the benefits of using Terraform modules?
A: Modules allow reusing infrastructure code, be consistent across created environments, and keep configs organized.
Q: Explain how to pass variables to a Terraform module.
A: Declare a var inside the module folder e.g. variable “instance_type” {}. assign the value in the root folder e.g. module “filename” {source “./path” instance_type = “xxxx”}. This will pass “xxxx” to the instance_type inside the module.
Q: What is the difference between count and for_each?
A: Count creates resource instances using a numeric index and is used for creating identical resources. If the number/order is changed, the indexes shift, so if you have different resources in the list, TF might destroy or recreate unintentionally.
   for_each creates instances based on keys from a set and is used for resources with unique identifiers.
Q: How do you source a module from a Git repository?
A: By using a git:: URL in the module source. You can also specify a branch, tag or commit using the ref parameter.

Terraform with AWS (4 questions)
Q: How do you create an EC2 instance with Terraform?
A: Using the aws_instance resource. It requires an AMI, instance type, subnet (which requires a vpc), and security group.
Q: What are the required fields for defining a VPC in Terraform?
A: Only CIDR is required. But common are also tags, dns support and dns hostnames.
Q: Explain how Terraform manages IAM policies in AWS.
A: You define a policy, a role and the attachment of them to each other. TF then tracks this in the state file, treats them as resources and enforces that IAM permissions match what is defined.
Q: How do you use Terraform to provision and attach an Elastic Load Balancer?
A: By defining a load balancer resource, target group, and a listener that forwards traffic to the target group. Then EC2 instances or auto scaling groups are attached to the target group, allowing the load balancer to route to them.

Debugging & Error Handling (4 questions) 
Q: What does the terraform validate command do?
A: Checks for syntax to ensure the config is written correctly, type checking and internal consistency to ensure that values match expected types and that all references are valid.

TF Exam repo:
https://github.com/Vladxgx/TF-EXAM/tree/main

# Build a VPC
## What to build
"A VPC configured with an instance in a public subnet, providing SSH connectivity for a developer environment"
* Components
    - A folder to store terraform files and templates
        - provider.tf *Specify provider*
        - main.tf *Build an infrastructure*
        - variables.tf *Specify variables*
        - datasources.tf **
        - output.tf

        - userdata.tpl
        - linux-ssh-config.tpl


## How to build - Plan
* Pre stage
    - Create a folder that terraform file will be located
        - All Terraform files will run based on the same level of directory
    * Set up terraform with AWS 
        - Create **a IAM user or IAM role** with relative permissions
        - Create **credential profile** with AWS extensions in VScode
            - Insert Access key and Secret Access key 
        - Create a **provider.tf**
            - Create terraform block and provider block
                - Connect the profile with the terraform files

* main.tf
    1. Create a VPC
        - Arguments
            - Specify CIDR range for VPC
            - enable_dns_hostnames *Instances in the VPC receive public DNS hostname*
            - enable_dns_support *Dns resolution = Convert Domain name into IP address*
            - Tag
    2. Create a public subnet
        - Arguments
            - VPC ID
            - CIDR block for subnet
            - map_public_ip_on_launch *Instances in the subnet will be asiigned with public IP*
            - availability_zone
            - Tag
    3. Create a IGW
        - Arguments
            - VPC ID
            - Tag
    4. Create a Route Table
        - Arguments
            - VPC ID
            - Tag
    5. Create a Route
        - Arguments
            - Route table ID
            - Gare way ID
            - Destination
    6. Create a Route association
        - Arguments
            - Subnet ID
            - Route Table ID
    7. Create a security group
        * What is it
            * Manage ingress and egress traffic in instance level
            * I will set up to allow only my IP address to enter.
        - Arguments
            - Name
            - Description
            - VPC ID
            - Ingress rule
            - Egrass rule
    8. Create a key-pair
        * What is it
            * Upload public key created in local machine. Only someone has Private key can enter the instance. 
        - pre
            - Create ssh key-pair by using ssh-keygen -t ed25519 *type ed25519*
            - Name the key pair by /.ssh/[**key-pair name**]
        - Arguamements
            - Key name
            - public key *From local dir, [key name].pub. Use file()*
    9. Create an Instance
        - Arguments



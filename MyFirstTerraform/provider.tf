terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region              = "us-west-2"
  shared_config_files = ["~/.aws/credentials"] #Credential must be a form of list[]
  profile             = "vscode"
}
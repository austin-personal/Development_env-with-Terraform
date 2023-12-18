# Terraform basics


Setting up variables
    - Initiate variables
        - Syntax
                variable "[name of var]"{
                    type = [string, number, list, map]
                    defualt = "[defualt value]" #If there is no defulat, it will ask when it plan, apply and destroy
                }
        - Use variable
                ${var.[variable name]}
    - Variable definition precedence 변수 순서
        - precedence
            1. -var, -var-file
                - terraform console -var="host_os=unix"
                - terraform console -var-file="dev.tfvars"
                * These will make use the variable whatever the variable specified. 
            2. *.auto.tfvars, *.auto.tfvars.json
            3. terraform.tfvars.json
            4. terraform.tfvars
            5. Environment variable

- Setting interpretor to adapt os in ssh config file dynamically
    - Insert the script into instance resource block
            var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "Command"]
        - This is condition expression
            - Syntax
                - [variable name] == "[condition]" ? "[If yes]" : "[If no]"
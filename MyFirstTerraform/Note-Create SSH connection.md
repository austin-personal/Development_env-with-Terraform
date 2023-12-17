Terraform Note
**Creating a remote SSH environment inside of EC2 intance based on the local os**
    - setting up SSH file
        - To go into EC2 instance via terminal
            1. Get values
                1. Public IP address of EC2
                2. SSH key path
                3. User
            2. Type
                - ssh -i ~/.ssh/mk_key ubuntu@54.191.150.254
                - ssh -i [ssh key path] [user]@[Publi IP address]
        - Ready to go inside EC2 instance by SSH config Scripts
            1. Create ssh-config.tpl
            2. Add Provisoner block inside instance resource block with parameter
            3. Replace instance blcok by re-apply instance resource block
            4. Check by "cat ~/.ssh/config". You can find new host
            5. Connect to host by finding "remote-ssh:connect to host"
                1. Select right public IP and OS
                2. It will  open a new vscode window
                3. Open terminal and it will show that you are in the instance

    - Setting up variables
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
                    # These will make use the variable whatever the variable specified. 
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
# Creating a remote SSH environment inside of EC2 intance based on the local os    
    
### setting up SSH file
#### Enter EC2 instance via terminal
1.  Values required
    - Public IP address of EC2
    - SSH key path
    - User
2. Write into Terminal
    - ssh -i ~/.ssh/mk_key ubuntu@54.111.111.111
    - Format: 
        ssh -i [ssh key path] [user]@[Publi IP address]
#### Build developer environment with SSH config Scripts to go inside EC2 instance
1. Create ssh-config.tpl for Host and userdata.tpl for instance config
2. Add user_data arguments in instance resource block
2. Add Provisoner block inside instance resource block with parameter
3. Refresh instance resource blcok by re-apply instance resource block
4. Check by "cat ~/.ssh/config". You can find new host
5. Connect to host by finding "remote-ssh:connect to host"
    1. Select right public IP and OS
    2. ***It will  open a new vscode window***
    3. ***Open new VScode terminal and it will show that you are in the instance***

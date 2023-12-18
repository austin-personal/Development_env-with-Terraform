add-content -path c:/users/austin/.ssh.config -value @'

Host ${hostname}
    Hostname ${hostname}
    User ${user}
    identityfile ${identityfile}
'@
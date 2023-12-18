add-content -path c:/users/austin/.ssh/config @'

Host ${hostname}
    Hostname ${hostname}
    User ${user}
    identityfile ${identityfile}
'@

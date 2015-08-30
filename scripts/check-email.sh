#!/bin/bash
# check for new emails

display_help() {
    echo "Usage check-email.sh [options]"
    echo "  -v --verbose    print info for all accounts and include emails"
    echo "  -q --quiet      print only total number of new emails"
    echo "  -h --help       display this help message and exit"
    echo
    echo "Default behavior is to print number of new emails and name of account only if account has new emails"
}

case $1 in
    -h|--help)
        display_help
        exit 0;;

esac

# data stored in 3 arrays: accounts, passwords, names
source ~/.config/email/secret

total=0
i=0
# loop through email accounts, checking for new mail
for account in ${accounts[@]}; do
    name=${names[$i]}
    password=${passwords[$i]}

    feed=$(curl -u $account:$password --silent https://mail.google.com/mail/feed/atom)
    
    if [ -n "$feed" ]; then
        new=$(echo $feed | grep -o "<entry>" | wc -l)
    else
        new=0
    fi

    total=$(($total + $new))

    i=$(($i + 1))
done

echo $total


#!/bin/bash
# check for new emails

display_help() {
    echo "Usage: check-email.sh [option]"
    echo "  -v --verbose    print lots of info"
    echo "  -q --quiet      print only total number of new emails"
    echo "  -h --help       display this help message and exit"
    echo
    echo "Default behavior is to print number of new emails and name of account only if account has new emails"
}

if [ $# -gt 1 ]; then
    display_help
    exit 1
fi

case $1 in
    -h|--help)
        display_help
        exit 0;;
    -v|--verbose)
        flag=v;;
    -q|--quiet)
        flag=q;;
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

    results[i]=$new
    total=$(($total + $new))

    i=$(($i + 1))
done

i=0
if [ -z $flag ]; then
    for result in ${results[@]}; do
        if [ $result != 0 ]; then
            echo "${names[$i]}: $result new"
        fi
        i=$(($i + 1))
    done
    exit 0

elif [ $flag = "q" ]; then
    echo $total
    exit 0

elif [ $flag = "v" ]; then
    for result in ${results[@]}; do
        echo "${names[$i]} <${accounts[$i]}>: $result new"
        i=$(($i + 1))
    done
    exit 0

else
    echo "Internal error!"
    exit 1
fi


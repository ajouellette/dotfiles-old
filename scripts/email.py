#!/usr/bin/env python
# this script returns the number of unread emails
# assumes email is a gmail account

import imaplib

emails = ["email"]
passwords = ["password"]

fullcount = 0

for x in range(0, len(emails)):

    email = emails[x]
    password  = passwords[x]

    obj = imaplib.IMAP4_SSL('imap.gmail.com', 993)
    obj.login(email, password)
    obj.select()
    data=obj.search(None, 'UNSEEN')
    fullcount += len(data[1][0].split())

print(fullcount)

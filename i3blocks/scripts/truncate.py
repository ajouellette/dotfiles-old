#!/usr/bin/env python

max_length = 60

def truncate(string):
    if len(string) < max_length:
        spaces = int((max_length - len(string)) / 2)
        return spaces * " " + string + spaces * " "
    else:
        start = string[0:int(max_length / 2)]
        end = string[-int(max_length / 2):]
        return start + "..." + end + " "

def main():
    while True:
        string = input()
        print(truncate(string))

if __name__ == "__main__":
    main()

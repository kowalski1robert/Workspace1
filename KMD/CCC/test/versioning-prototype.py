import sys
import re
import subprocess
import base64
import os
# import argparse

# parser = argparse.ArgumentParser()
# parser.add_argument('--last-tag', '-t', dest='last_tag', type=str, required=True)
# parser.add_argument('--commit-message', '-m', dest='commit_message', type=str, required=True)
# args = parser.parse_args()

# commit_message = args.commit_message
# last_tag = args.last_tag
# commit_message = sys.argv[0]
b = subprocess.getoutput("git log --format=%B -n 1")
commit_message = "fix:"
last_tag = subprocess.getoutput("git describe --tags")

last_tag = re.findall("[0-9]+", last_tag)

if re.match("^[a-z, A-Z]+:", commit_message) is not None:
    commit_message_prefix = re.match("^[a-z, A-Z]+:", commit_message).string
else:
    raise ValueError('Commit message is not valid according to conventional commit rules. Use "fix:", "feat:" or "BREAKING CHANGE:" at the beginning of the message')

if commit_message_prefix == "fix:":
    last_tag[2] = str(int(last_tag[2]) + 1)
elif commit_message_prefix == "feat:":
    last_tag[1] = str(int(last_tag[1]) + 1)
    last_tag[2] = "0"
elif commit_message_prefix == "BREAKING CHANGE:":
    last_tag[0] = str(int(last_tag[0]) + 1)
    last_tag[1] = "0"
    last_tag[2] = "0"

new_tag = "v" + ".".join(last_tag)

# def computing_new_tag():
#     last_tag = re.findall("[0-9]+", last_tag)

#     if re.match("^[a-z, A-Z]+:", commit_message) is not None:
#         commit_message_prefix = re.match("^[a-z, A-Z]+:", commit_message).string
#     else:
#         raise ValueError('Commit message is not valid according to conventional commit rules. Use "fix:", "feat:" or "BREAKING CHANGE:" at the beginning of the message')

#     if commit_message_prefix == "fix:":
#         last_tag[2] = str(int(last_tag[2]) + 1)
#     elif commit_message_prefix == "feat:":
#         last_tag[1] = str(int(last_tag[1]) + 1)
#     elif commit_message_prefix == "BREAKING CHANGE:":
#         last_tag[0] = str(int(last_tag[0]) + 1)

#     return ("v" + ".".join(last_tag))

# computing_new_tag()
import re
import subprocess

commit_message = subprocess.getoutput("git log --format=%B -n 1")
last_tag = subprocess.getoutput("git describe --tags")

last_tag = re.findall("[0-9]+", last_tag)[:3]

if re.match("^[a-z, A-Z]+:", commit_message) is not None:
    commit_message_prefix = re.match("^[a-z, A-Z]+:", commit_message).group(0)
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
print(f"##vso[task.setvariable variable=new_tag]{new_tag}")

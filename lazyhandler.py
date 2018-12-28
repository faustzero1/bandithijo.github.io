#!/bin/env python3

#  ██████                           ██ ██   ██   ██      ██ ██    ██
# ░█░░░░██                         ░██░░   ░██  ░██     ░██░░    ░░
# ░█   ░██   ██████   ███████      ░██ ██ ██████░██     ░██ ██    ██  ██████
# ░██████   ░░░░░░██ ░░██░░░██  ██████░██░░░██░ ░██████████░██   ░██ ██░░░░██
# ░█░░░░ ██  ███████  ░██  ░██ ██░░░██░██  ░██  ░██░░░░░░██░██   ░██░██   ░██
# ░█    ░██ ██░░░░██  ░██  ░██░██  ░██░██  ░██  ░██     ░██░██ ██░██░██   ░██
# ░███████ ░░████████ ███  ░██░░██████░██  ░░██ ░██     ░██░██░░███ ░░██████
# ░░░░░░░   ░░░░░░░░ ░░░   ░░  ░░░░░░ ░░    ░░  ░░      ░░ ░░  ░░░   ░░░░░░

# author : Rizqi Nur Assyaufi
# email  : bandithijo@gmail.com
# web    : https://bandithijo.com

# lazyhandler.py, adalah python script sederhana yang bertujuan untuk
# menghandle proses jekyll build, git add, git commit dan git push ke dalam dua
# repository GitLab dan GitHub untuk blog bandithijo.com

import os

srcDir = "$HOME/dex/bandithijo.com"
pubDir = "$HOME/dex/bandithijo.com/_site"

msgCom = input("Masukkan pesan COMMIT: ")

os.system(f'''
# -----------------------------------------------------------------------------
# #### PROSES JEKYLL BUILD
# -----------------------------------------------------------------------------
echo '###############################'
echo '##### PROSES JEKYLL BUILD #####'
echo '###############################'
cd {srcDir}
JEKYLL_ENV=production jekyll build

echo '\n[DONE] Proses Jekyll Build\n'
sleep 3
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# #### PROSES GIT ADD COMMIT PUSH KE GITHUB
# -----------------------------------------------------------------------------
echo '################################################'
echo '##### PROSES GIT ADD COMMIT PUSH KE GITHUB #####'
echo '################################################'
cd {pubDir}
rm {pubDir}/feed.xml
rm {pubDir}/lazyhandler.py
git add .; git commit -m "{msgCom}"; git push origin master

echo '\n[DONE] Proses Git Add, Commit, dan Commit ke GitHub\n'
sleep 3
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# #### PROSES GIT ADD COMMIT PUSH KE GITLAB
# -----------------------------------------------------------------------------
echo '################################################'
echo '##### PROSES GIT ADD COMMIT PUSH KE GITLAB #####'
echo '################################################'
cd {srcDir}
git add .; git commit -m "{msgCom}"; git push origin master

echo '\n[DONE] Proses Git Add, Commit, dan Commit ke GitLab\n'
sleep 3
# -----------------------------------------------------------------------------
''')

# Print Output ----------------------------------------------------------------
print(f'''
d8888b.  .d88b.  d8b   db d88888b db
88  `8D .8P  Y8. 888o  88 88'     88
88   88 88    88 88V8o 88 88ooooo YP
88   88 88    88 88 V8o88 88~~~~~
88  .8D `8b  d8' 88  V888 88.     db
Y8888D'  `Y88P'  VP   V8P Y88888P YP
''')
print('\n>> LAZYHANDLER PROCESS COMPLETED !!')


# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4

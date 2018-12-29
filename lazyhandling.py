#!/bin/env python

#  ██████                           ██ ██   ██   ██      ██ ██    ██
# ░█░░░░██                         ░██░░   ░██  ░██     ░██░░    ░░
# ░█   ░██   ██████   ███████      ░██ ██ ██████░██     ░██ ██    ██  ██████
# ░██████   ░░░░░░██ ░░██░░░██  ██████░██░░░██░ ░██████████░██   ░██ ██░░░░██
# ░█░░░░ ██  ███████  ░██  ░██ ██░░░██░██  ░██  ░██░░░░░░██░██   ░██░██   ░██
# ░█    ░██ ██░░░░██  ░██  ░██░██  ░██░██  ░██  ░██     ░██░██ ██░██░██   ░██
# ░███████ ░░████████ ███  ░██░░██████░██  ░░██ ░██     ░██░██░░███ ░░██████
# ░░░░░░░   ░░░░░░░░ ░░░   ░░  ░░░░░░ ░░    ░░  ░░      ░░ ░░  ░░░   ░░░░░░

# Copyright (C) 2018 BanditHijo
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

# author  : BanditHijo
# website : https://bandithijo.com
# email   : bandithijo@gmail.com

# lazyhandling.py, adalah python script sederhana untuk menghandle Jekyll Build
# , git commit dan git push ke GitHub dan GitLab repository bandithijo.com

import os
import sys

# Daftar direktori
srcDir = "$HOME/dex/bandithijo.com"
pubDir = "$HOME/dex/bandithijo.com/_site"

# Meminta commit message kepada user
try:
    sys.argv[1]
except IndexError:
    comMsg = input('Masukkan pesan COMMIT: ')
else:
    comMsg = sys.argv[1]

os.system(f'''
# -----------------------------------------------------------------------------
# #### PROSES JEKYLL BUILD
# -----------------------------------------------------------------------------
echo '###########################'
echo '### PROSES JEKYLL BUILD ###'
echo '###########################'
cd {srcDir}
JEKYLL_ENV=production jekyll build

echo '\n[ DONE ] Jekyll Build Env=production\n'
sleep 5
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# #### PROSES ADD, COMMIT, PUSH PUBLIC REPO
# -----------------------------------------------------------------------------
echo '######################################################'
echo '### PROSES ADD, COMMIT, PUSH PUBLIC REPO TO GITHUB ###'
echo '######################################################'
cd {pubDir}
rm {pubDir}/lazyhandling.py
rm {pubDir}/feed.xml
git add .; git commit -m "{comMsg}"; git push origin master

echo '\n[ DONE ] Add, Commit, and Push to GitHub Repo\n'
sleep 5
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# #### PROSES ADD, COMMIT, PUSH SOURCE REPO
# -----------------------------------------------------------------------------
echo '######################################################'
echo '### PROSES ADD, COMMIT, PUSH PUBLIC REPO TO GITLAB ###'
echo '######################################################'
cd {srcDir}
git add .; git commit -m "{comMsg}"; git push origin master

echo '\n[ DONE ] Add, Commit, and Push to GitLab Repo\n'
sleep 2
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
print('\n>> AUTOBUILD PROCESS COMPLETED !!')


# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4

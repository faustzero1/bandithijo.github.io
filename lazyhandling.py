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

# author : BanditHijo
# website: https://bandithijo.com
# email  : bandithijo@gmail.com

# lazyhandling.py, adalah python script sederhana untuk menghandle Jekyll Build
# , git commit dan git push ke dalam GitHub dan GitLab repository.

import os

# Daftar direktori
srcDir = "$HOME/dex/bandithijo.com"
pubDir = "$HOME/dex/bandithijo.com/_site"

# Meminta commit message kepada user
comMsg = input("Masukkan pesan COMMIT: ")

os.system(f'''
# -----------------------------------------------------------------------------
# #### PROSES JEKYLL BUILD
# -----------------------------------------------------------------------------
cd {srcDir}
JEKYLL_ENV=production jekyll build

echo '[ DONE ] Jekyll Build Env=production'
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# #### PROSES ADD, COMMIT, PUSH PUBLIC REPO
# -----------------------------------------------------------------------------
cd {pubDir}
git add .; git commit -m "{comMsg}"; git push origin master

echo '[ DONE ] Add, Commit, and Push to GitHub Repo'
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# #### PROSES ADD, COMMIT, PUSH SOURCE REPO
# -----------------------------------------------------------------------------
cd {srcDir}
git add .; git commit -m "{comMsg}"; git push origin master

echo '[ DONE ] Add, Commit, and Push to GitLab Repo'
# -----------------------------------------------------------------------------
''')

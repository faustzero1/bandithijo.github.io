#!/usr/local/bin/ruby

#  ██████                           ██ ██   ██   ██      ██ ██    ██
# ░█░░░░██                         ░██░░   ░██  ░██     ░██░░    ░░
# ░█   ░██   ██████   ███████      ░██ ██ ██████░██     ░██ ██    ██  ██████
# ░██████   ░░░░░░██ ░░██░░░██  ██████░██░░░██░ ░██████████░██   ░██ ██░░░░██
# ░█░░░░ ██  ███████  ░██  ░██ ██░░░██░██  ░██  ░██░░░░░░██░██   ░██░██   ░██
# ░█    ░██ ██░░░░██  ░██  ░██░██  ░██░██  ░██  ░██     ░██░██ ██░██░██   ░██
# ░███████ ░░████████ ███  ░██░░██████░██  ░░██ ░██     ░██░██░░███ ░░██████
# ░░░░░░░   ░░░░░░░░ ░░░   ░░  ░░░░░░ ░░    ░░  ░░      ░░ ░░  ░░░   ░░░░░░

# Copyright (C) 2019 BanditHijo
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
# created : 01 May 2019

# lazyhandling.rb, adalah ruby script sederhana untuk menghandle Jekyll Build
# , git add, commit dan push ke GitHub dan GitLab repository bandithijo.com

# TODO
# 1. ...

# Daftar direktori
srcDir = '$HOME/dex/bandithijo.com'

# Meminta commit message kepada user
if ARGV.inspect == '[]'
  print 'Masukkan pesan COMMIT: '
  comMsg = gets.chomp
else
  comMsg = ARGV.inspect
  comMsg.tr!('["]', '')
end

# Proses Jekyll build
puts '#' * 80
puts '#' * 29 + ' PROSES JEKYLL BUILD ' + '#' * 30
puts '#' * 80
system """
cd #{srcDir}
JEKYLL_ENV=production bundle exec jekyll build
"""
puts "\n[ DONE ] Jekyll Build Env=production"
puts '-' * 80

# Proses add, commit, push ke GitHub
puts '#' * 80
puts '#' * 19 + ' PROSES: ADD, COMMIT, PUSH >> GITHUB REPO ' + '#' * 19
puts '#' * 80
system """
cd #{srcDir}
git add -A
git commit -m '#{comMsg}'
git push -u github master
"""
puts "\n[ DONE ] Add, Commit, and Push to GitHub Repo\n"
puts '-' * 80

# Proses add, commit, push ke GitLab
puts '#' * 80
puts '#' * 19 + ' PROSES: ADD, COMMIT, PUSH >> GITLAB REPO ' + '#' * 19
puts '#' * 80
system """
cd #{srcDir}
git add -A
git commit -m '#{comMsg}'
git push -u gitlab master
"""
puts "\n[ DONE ] Add, Commit, and Push to GitLab Repo\n"
puts '-' * 80

puts """
d8888b.  .d88b.  d8b   db d88888b db
88  `8D .8P  Y8. 888o  88 88'     88
88   88 88    88 88V8o 88 88ooooo YP
88   88 88    88 88 V8o88 88~~~~~
88  .8D `8b  d8' 88  V888 88.     db
Y8888D'  `Y88P'  VP   V8P Y88888P YP
"""

puts "\n>> AUTOBUILD PROCESS COMPLETED !!"

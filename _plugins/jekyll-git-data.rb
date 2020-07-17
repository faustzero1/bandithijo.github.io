# Jekyll plugin for generating current build's Git data
#
# This file needs to be placed in the _plugins directory
# and the site.data[' '] variables can be used in the Liquid templates
#

module Githash
  class GitHashGenerator < Jekyll::Generator
    priority :high
    safe true
    def generate(site)
      shorthash = %x( git rev-parse --short HEAD ).strip
      longhash = %x( git rev-parse HEAD ).strip
      currentbranch = %x( git rev-parse --abbrev-ref HEAD ).strip
      site.data['shorthash'] = shorthash
      site.data['longhash'] = longhash
      site.data['currentbranch'] = currentbranch
    end
  end
end

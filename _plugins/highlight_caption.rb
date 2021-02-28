# Jekyll - Easy Highlight Caption
# BanditHijo - https://github.com/bandithijo
#
#   Input:
#     {% highlight_caption /etc/pacman.d/mirrorlist %}
#
#   Output:
#     <div class="highlight-caption">
#       <span class="label">FILE</span>
#       <code>/etc/default/grub</code>
#       <span>FILE</span>
#     </div>

module Jekyll
  class HighlightCaption < Liquid::Tag
    @path = nil

    FILE_PATH = /(\S+)/i

    def initialize(tag_name, file_path, tokens)
      super

      if file_path =~ FILE_PATH
        @path = $1
      end
    end

    def render(_context)
      source  = '<div class="highlight-caption">'
      source += '<span class="label">FILE</span>'
      source += "<code>#{@path}</code>"
      source += '</div>'
      source
    end
  end
end

Liquid::Template.register_tag('highlight_caption', Jekyll::HighlightCaption)

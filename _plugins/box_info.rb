module Jekyll
  class BoxInfo < Liquid::Block
    def render(context)
      content = super

      text  = '<!-- INFORMATION -->'
      text += '<div class="blockquote-blue">'
      text += '<div class="blockquote-blue-title">[ i ] Informasi</div>'
      text += "<div markdown='1'>#{content}</div>"
      text += '</div>'
      text
    end
  end
end

Liquid::Template.register_tag('box_info', Jekyll::BoxInfo)

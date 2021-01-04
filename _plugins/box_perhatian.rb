module Jekyll
  class BoxPerhatian < Liquid::Block
    def render(context)
      content = super

      text  = '<!-- PERHATIAN -->'
      text += '<div class="blockquote-red">'
      text += '<div class="blockquote-red-title">[ ! ] Perhatian</div>'
      text += "<div markdown='1'>#{content}</div>"
      text += '</div>'
      text
    end
  end
end

Liquid::Template.register_tag('box_perhatian', Jekyll::BoxPerhatian)

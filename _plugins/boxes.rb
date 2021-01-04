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

  class BoxPertanyaan < Liquid::Block
    def render(context)
      content = super.split("\n")

      text  = '<!-- PERTANYAAN -->'
      text += '<div class="blockquote-yellow">'
      text += "<div class='blockquote-yellow-title'>#{content[1]}</div>"
      text += "<div markdown='1'>"
      text += "#{content[2..].map { |i| "#{i}" }.join}"
      text += '</div>'
      text += '</div>'
      text
    end
  end
end

Liquid::Template.register_tag('box_info',       Jekyll::BoxInfo)
Liquid::Template.register_tag('box_perhatian',  Jekyll::BoxPerhatian)
Liquid::Template.register_tag('box_pertanyaan', Jekyll::BoxPertanyaan)

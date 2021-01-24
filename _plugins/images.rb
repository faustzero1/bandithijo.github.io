module Jekyll
  class Image < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      params = split_params(@input)
      url = params[0].strip
      num = params[1].strip if params.length > 1
      cap = params[2].strip if params.length > 2

      output  = "![gambar_#{num}](/assets/img/logo/logo_blank.svg){:data-echo='#{url}' onerror='imgError(this);'}{:class='myImg'}"
      output += "\n<p class='img-caption'>Gambar #{num} - #{cap}</p>" if params.length == 3
      output
    end

    def split_params(params)
      params.split(' | ')
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::Image)

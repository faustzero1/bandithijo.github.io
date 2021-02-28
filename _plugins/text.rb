module Jekyll
  class TextLatin < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(_context)
      input  = @input
      output = "<p class='font-latin' style='padding-top:20px;text-align:left;'>#{input}</p>"
      output
    end
  end
end

Liquid::Template.register_tag('text_latin', Jekyll::TextLatin)

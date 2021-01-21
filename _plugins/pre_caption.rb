module Jekyll
  class PreCaption < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre class="caption">'
      text += commands[1..].map do |i|
        "#{i}<br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end
end

Liquid::Template.register_tag('pre_caption',  Jekyll::PreCaption)

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

  class PreUrl < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre class="url">'
      text += commands[1..].map do |i|
        "#{i}<br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end

  class PreWhiteboard < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre class="whiteboard">'
      text += commands[1..].map do |i|
        "#{i}<br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end
end

Liquid::Template.register_tag('pre_caption',    Jekyll::PreCaption)
Liquid::Template.register_tag('pre_url',        Jekyll::PreUrl)
Liquid::Template.register_tag('pre_whiteboard', Jekyll::PreWhiteboard)

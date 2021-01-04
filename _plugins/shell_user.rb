module Jekyll
  class ShellUser < Liquid::Block
    def render(context)
      command = super.gsub(/\s+/, ' ')
      text  = '<pre>'
      text += "$<b>#{command}</b>"
      text += '</pre>'
      text
    end
  end
end

Liquid::Template.register_tag('shell_user', Jekyll::ShellUser)

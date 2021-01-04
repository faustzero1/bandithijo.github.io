module Jekyll
  class ShellRoot < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += commands[1..].map { |i| "# <b>#{i}</b>\n" }.join.to_s
      text += '</pre>'
      text
    end
  end

  class ShellUser < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += commands[1..].map { |i| "$ <b>#{i}</b>\n" }.join.to_s
      text += '</pre>'
      text
    end
  end
end

Liquid::Template.register_tag('shell_root',  Jekyll::ShellRoot)
Liquid::Template.register_tag('shell_user',  Jekyll::ShellUser)

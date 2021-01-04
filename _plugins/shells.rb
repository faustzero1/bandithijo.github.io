module Jekyll
  class ShellRoot < Liquid::Block
    def render(context)
      command = super.gsub(/\s+/, ' ')
      text  = '<pre>'
      text += "#<b>#{command}</b>"
      text += '</pre>'
      text
    end
  end

  class ShellRoots < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += "#{commands[1..].map { |i| "# <b>#{i}</b>\n" }.join}"
      text += '</pre>'
      text
    end
  end

  class ShellUser < Liquid::Block
    def render(context)
      command = super.gsub(/\s+/, ' ')
      text  = '<pre>'
      text += "$<b>#{command}</b>"
      text += '</pre>'
      text
    end
  end

  class ShellUsers < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += "#{commands[1..].map { |i| "$ <b>#{i}</b>\n" }.join}"
      text += '</pre>'
      text
    end
  end
end

Liquid::Template.register_tag('shell_root',  Jekyll::ShellRoot)
Liquid::Template.register_tag('shell_roots', Jekyll::ShellRoots)
Liquid::Template.register_tag('shell_user',  Jekyll::ShellUser)
Liquid::Template.register_tag('shell_users', Jekyll::ShellUsers)

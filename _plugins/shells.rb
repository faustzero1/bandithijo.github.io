module Jekyll
  class ShellRoot < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += commands[1..].map do |i|
        "<span class='cmd'># </span><b>#{i}</b><br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end

  class ShellUser < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = '<pre>'
      text += commands[1..].map do |i|
        "<span class='cmd'>$ </span><b>#{i}</b><br>"
      end.join.to_s
      text += '</pre>'
      text
    end
  end

  # SHELL PROMPT WITH CUSTOM PARAMETER
  # You can add custom prompt & color. And able to use with multiline.
  # How to use?
  # {% shell_cmd $ | EB3D2D %}
  # sudo pacman -Syy
  # {% endshell_cmd %}
  class ShellCommand < Liquid::Block
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      params = split_params(@input)
      prompt_symbol = params[0]&.strip
      color = params[1]&.strip if params.length > 1

      commands = super.split("\n")
      output  = '<pre>'
      output += commands[1..].map do |i|
        if color&.nil? && color&.empty?
          "<span class='cmd'>#{prompt_symbol.nil? ? '$' : prompt_symbol} </span><b>#{i}</b><br>"
        else
          "<span class='cmd' style='color:##{color};'>#{prompt_symbol.nil? ? '$' : prompt_symbol} </span><b>#{i}</b><br>"
        end
      end.join.to_s
      output += '</pre>'
      output
    end

    def split_params(params)
      params.split(' | ')
    end
  end
end

Liquid::Template.register_tag('shell_root', Jekyll::ShellRoot)
Liquid::Template.register_tag('shell_user', Jekyll::ShellUser)
Liquid::Template.register_tag('shell_cmd',  Jekyll::ShellCommand)

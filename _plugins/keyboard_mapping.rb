module Jekyll

  # <span class="keyboard-mapping">
  # C-x k
  # </span>
  class KeyboardMapping < Liquid::Block
    def render(context)
      commands = super.split("\n")
      text  = "<span class='keyboard-mapping'>"
      text += commands[1..].map do |i|
        "#{i}<br>"
      end.join.to_s
      text += '</span>'
      text
    end
  end
end

Liquid::Template.register_tag('keymap', Jekyll::KeyboardMapping)

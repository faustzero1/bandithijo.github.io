module Jekyll
  class Contributor < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(_context)
      contributors = split_params(@input)
      $output  = "<span class='kontributor-box'>"
      $output += "<span style='float:left;position:relative;top:18px;margin-right:10px;'>"
      $output += contributors.count <= 1 ? "<b>Kontributor:</b></span>" : "<b>Para Kontributor:</b></span>"
      contributors.each do |contrib|
        $output += "<a href='https://github.com/#{contrib.strip}' style='border-bottom:none;' target='_blank'>"
        $output += "<img class='kontributor-img' src='https://github.com/#{contrib.strip}.png' alt='#{contrib.strip}' onerror='imgError(this);'>"
        $output += "</a>"
      end
      $output += "</span>"
      $output
    end

    def split_params(params)
      params.split(" | ")
    end
  end
end

Liquid::Template.register_tag('contributor', Jekyll::Contributor)

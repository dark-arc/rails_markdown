require 'redcarpet'
module RailsMarkdown
  class Markdown
    def initialize
      config = File.join(Rails.root, 'config', 'markdown.yml')
      config = YAML.load_file config
      formatter = Formatter.new(config['options'])
      @markdown = ::Redcarpet::Markdown.new(formatter,config['extensions'])
    end

    def render(string)
      return nil if string.nil?
      @markdown.render string
    end
  end
end

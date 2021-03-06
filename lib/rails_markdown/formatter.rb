require 'redcarpet'
module RailsMarkdown
  # Adds some additional formatting to the Redcarpet markdown parser.
  class Formatter < ::Redcarpet::Render::HTML
    
    # Generate a new instance of the formatter object (Markdown
    # Parser). This will accept the same options as all redcarpet
    # renderers with the addition of link and models, which can be used
    # to define the syntax for links and which models should be
    # searched.
    def initialize(options = {})
      @links = options['link'] || /<(.*)\?(.*)>/
      @models = options['models'] || {}
      @url_helpers = Rails.application.routes.url_helpers
      super(options)
    end

    # Overrides the Redcarpet::Render::HTML method preprocess to call
    # our link parser
    def preprocess(text)
      text = parse_special_links(text)
      return text
    end
    
    # This method is called by preprocess and will look through the
    # current text for "special links". The format of these links is
    # defined by @links, by default this will parse <people?1> as
    # /people/1. Links will only be generated for defined models
    # (@models).
    #
    # @param text [String] the text to translate
    # @return [String] translated text
    def parse_special_links(text="")
      text.gsub! @links do
        model,link = $1,$2
        mod = model.camelize 

        if @models.keys.include? mod
          con = model.tableize
          ins = mod.constantize.find_by_id link
          url = @url_helpers.url_for(controller: con, action: :show, id: link, only_path: true)
          if(ins.nil?)
            tag = "invalid reference(#{$2})"
          else
            tag = ins.send @models[mod]
          end
          "[#{tag}](#{url})"
        else
          "invalid tag (#{mod} => #{@models.keys.to_sentence})"
        end
      end
      return text
    end
  end
end

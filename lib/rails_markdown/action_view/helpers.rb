module RailsMarkdown
  module ActionView
    module Helpers
      def markdown(string)
        @markdown ||= Markdown.new
        @markdown.render(string).html_safe
      end
    end
  end
end

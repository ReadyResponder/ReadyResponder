module ActionView
  module Template::Handlers
  class MarkdownHandler
    class_attribute :default_format
    self.default_format = Mime[:HTML]
    def erb
      @erb ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb.call(template)
      "Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(with_toc_data: true), no_intra_emphasis: true,
      autolink: true, tables: true).render(begin;#{compiled_source};end).html_safe"
    end
  end
  end
end

ActionView::Template.register_template_handler(
  :md, ActionView::Template::Handlers::MarkdownHandler.new)

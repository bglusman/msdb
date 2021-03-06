module NAMESPACE
  class Report < ::Report
    attr_accessor :for_date, :title

    def self.template
      # prepending "/" to the template path is necessary b/c ActionController removes the leading "/", so add a second one that it can have its way with!
      "/" + NAMESPACE::Engine.root.join(template_path).to_s
    end

    def self.template_path
      "app/document_templates/report_name"
    end
  end
end

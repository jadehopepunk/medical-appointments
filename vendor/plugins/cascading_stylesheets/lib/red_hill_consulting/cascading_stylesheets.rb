module RedHillConsulting
  module CascadingStylesheets
    module AssetTagHelper
      def self.included(base)
        base.class_eval do
          alias_method :stylesheet_link_tag_without_cascade, :stylesheet_link_tag unless method_defined?(:stylesheet_link_tag_without_cascade)
          alias_method :stylesheet_link_tag, :stylesheet_link_tag_with_cascade
        end
      end
    
      def stylesheet_link_tag_with_cascade(*sources)
        if sources.include?(:defaults)
          sources = sources.dup
          sources.delete(:defaults)
          
          candidates = controller.class.controller_path.split("/").inject([nil, nil]) { |candidates, candidate| candidates << (candidates.last ? File.join(candidates.last, candidate) : candidate) }
          candidates[0] = "application"
          candidates[1] = RAILS_ENV
          candidates << File.join(candidates.last, controller.action_name)

          candidates.each do |candidate|
            sources << candidate if File.exists?(File.join(RAILS_ROOT, "public/stylesheets", "#{candidate}.css"))
          end
        end

        stylesheet_link_tag_without_cascade(*sources)
      end
    end
  end
end

module RedHillConsulting
  module CascadingJavascripts
    module AssetTagHelper
      def self.included(base)
        base.class_eval do
          alias_method :javascript_include_tag_without_cascade, :javascript_include_tag unless method_defined?(:javascript_include_tag_without_cascade)
          alias_method :javascript_include_tag, :javascript_include_tag_with_cascade
        end
      end
    
      def javascript_include_tag_with_cascade(*sources)
        if sources.include?(:defaults)
          ["#{@controller.controller_name}/#{@controller.action_name}"].each do |source|
            sources << source if File.exists?("#{RAILS_ROOT}/public/javascripts/#{source}.js")
          end
        end

        javascript_include_tag_without_cascade(*sources)
      end
    end
  end
end

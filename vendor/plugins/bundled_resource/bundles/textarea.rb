module BundledResource::Textarea
  def bundle
    require_stylesheet "/bundles/textarea/stylesheets/resizable"

    require_javascript "/bundles/textarea/javascripts/resizable"
    require_javascript "/bundles/textarea/javascripts/wordcount"
  end
end
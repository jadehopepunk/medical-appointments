# == Usage ==
# require_bundle :lightbox
#
# Surround a thumbnail image inside of an anchor tag like this:
#   <a href="/images/large-image.jpg" rel="lightbox">
#     <img src="/images/thumbnail.jpg">
#   </a>
#
# And your thumbnails will turn in to full-sized images within the browser window when clicked on!
#
# == Full Lightbox Documenation ==
# http://www.huddletogether.com/projects/lightbox/

module BundledResource::Lightbox
  def bundle
    require_javascript "/bundles/lightbox/javascripts/lightbox"
    
    require_stylesheet "/bundles/lightbox/stylesheets/lightbox"
  end
end
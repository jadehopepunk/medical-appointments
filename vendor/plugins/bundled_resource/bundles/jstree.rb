# Example HTML:
#
=begin
<ul id='tree' class="jstree">
  <li class="collapsed">Root node 1 has a <a href="#">link</a><ul>
    <li class="expanded">Node 1.1<ul>
      <li>Node 1.1.1 has a <a href="#">link</a></li>
    </ul></li>
  </ul></li>
  <li>Root node 2<ul>
    <li>Node 2.1<ul>
      <li>Node 2.1.4</li>
    </ul></li>
  </ul></li>
</ul>
=end

module BundledResource::Jstree
  def bundle
    require_stylesheet "/bundles/jstree/stylesheets/resizable"

    require_javascript "prototype"
    require_javascript "effects"
    require_javascript "/bundles/jstree/javascripts/behaviour"
    require_javascript "/bundles/jstree/javascripts/jstree"
  end
end

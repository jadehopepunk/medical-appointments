# Find out if we have any bundles
bundle_directory_root = File.join(File.dirname(__FILE__), 'bundles')

bundle_glob = File.join(bundle_directory_root, '*.rb')
bundle_files = Dir.glob(bundle_glob)

if bundle_files.size > 0 and (ENV['RAILS_BUNDLES'].nil? or ENV['RAILS_BUNDLES'].upcase == 'YES')
  # We need to load each ruby file in the bundles directory.  Each file should
  # contain a module within the BundledResource module, e.g.
  #   module BundledResource::Qforms
  #     def bundle
  #       require_javascript '...' # require whatever resources are necessary
  #     end
  #  end
  #
  # Note that the single 'bundle' method can have optional parameters if needed.

  require 'require_resource'
  require 'bundled_resource'

  RAILS_DEFAULT_LOGGER.debug "Resource Bundles: #{bundle_files.size}"
  bundle_files.each do |filename|
    name = File.basename(filename)
    name = name[0...-3] if name =~ /\.rb$/
  
    RAILS_DEFAULT_LOGGER.debug "Requiring Bundle\n  #{filename}"
    require filename
  
    # Rename the generic 'bundle' method in to something that doesn't conflict with
    # the other module method names.
    bundle_module = BundledResource.const_get(name.to_s.camelize)
    bundle_module.module_eval "alias bundle_#{name} bundle"
    bundle_module.send :undef_method, :bundle

    # Then include the bundle module in to the base module, so that the methods will
    # be available inside ActionView::Base
    BundledResource.send(:include, bundle_module)
  
    # Check for optional Controller module
    if bundle_module.const_defined? 'Controller'
      controller_addon = bundle_module.const_get('Controller')
      RAILS_DEFAULT_LOGGER.debug "Including #{name} bundle's Controller module"
      ActionController::Base.send(:include, controller_addon)
    end

    # Check for optional Helper module
    if bundle_module.const_defined? 'Helper'
      helper_addon = bundle_module.const_get('Helper')
      RAILS_DEFAULT_LOGGER.debug "Including #{name} bundle's Helper module"
      ActionView::Base.send(:include, helper_addon)
    end
  end

  public_bundle_directory = File.expand_path(File.join(RAILS_ROOT, "public", "bundles"))

  BundledResource.create_public_bundle_directory(public_bundle_directory)
  BundledResource.copy_bundles(bundle_directory_root, public_bundle_directory)

  ActionView::Base.send(:include, RequireResource)
  ActionView::Base.send(:include, BundledResource)
end
require 'fileutils'

BUNDLE_RESOURCE_README = <<-END
Files in this directory are automatically generated from your Rails bundles.
They are copied from the directories of each bundle into this directory
each time Rails starts (server, console). Any edits you make will NOT
persist across the next server restart; instead you should edit the files within
the bundle directory itself (e.g. vendor/plugins/bundle_resource/bundles/*).
END

module BundledResource
  def require_bundle(name, *args)
    method = "bundle_#{name}"
    send(method, *args)
  end
  
  def self.copy_bundles(bundle_directory_root, public_bundle_directory)
    RAILS_DEFAULT_LOGGER.debug "Copying bundles from\n  #{bundle_directory_root} to\n  #{public_bundle_directory}"
    Dir.new(bundle_directory_root).each do |entry|
      full_path = File.join(bundle_directory_root, entry)
      if File.directory?(full_path)
        unless ['.', '..', '.svn'].include?(entry)
          BundledResource.copy_files(full_path, public_bundle_directory)
        end
      end
    end
    RAILS_DEFAULT_LOGGER.debug "Done copying bundles."
  end

  def self.create_public_bundle_directory(public_bundle_dir)
    if File.exists?(public_bundle_dir)
      RAILS_DEFAULT_LOGGER.debug "Removing bundles directory\n  #{public_bundle_dir}"
      FileUtils.rm_rf(public_bundle_dir)
    end

    RAILS_DEFAULT_LOGGER.debug "Creating bundles directory\n  #{public_bundle_dir}"
    # create the public/engines directory, with a warning message in it.
    FileUtils.mkdir(public_bundle_dir)
    File.open(File.join(public_bundle_dir, "README"), "w") do |f|
      f.puts BUNDLE_RESOURCE_README
    end
  end
  
  # Replicates the subdirectories under the bundle's directory into
  # the application's public directory.
  def self.copy_files(source, destination)
    FileUtils.cp_r(source, destination) rescue nil
  end
end
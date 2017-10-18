require 'blacklight'
require 'blacklight_oai_provider'
require 'rails'

module BlacklightOaiProvider
  class Engine < Rails::Engine
    # Do these things in a to_prepare block, to try and make them work
    # in development mode with class-reloading. The trick is we can't
    # be sure if the controllers we're modifying are being reloaded in
    # dev mode, if they are in the BL plugin and haven't been copied to
    # local, they won't be. But we do our best.
    config.to_prepare do
      BlacklightOaiProvider.inject!
    end

    # Add XSL Stylesheet to list of assets to be precompiled.
    initializer "blacklight_oai_provider.assets.precompile" do |app|
      app.config.assets.precompile += %w[blacklight_oai_provider/oai2.xsl]
    end

    # Load rake tasks.
    rake_tasks do
      Dir.chdir(File.expand_path(File.join(File.dirname(__FILE__), '..'))) do
        Dir.glob(File.join('railties', '*.rake')).each do |railtie|
          load railtie
        end
      end
    end
  end
end

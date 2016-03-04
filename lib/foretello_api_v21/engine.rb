require 'active_model_serializers'

module ForetelloApiV21
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/serializers"]

    initializer 'foretello_api_v21.register_plugin' do |app|
      Foreman::Plugin.register :foretello_api_v21 do
        requires_foreman '>= 1.7'

        security_block :foretello_api_v21 do
          permission :rename_discovered_hosts, {
            :"api/v21/discovered_hosts" => [:rename]
          }, :resource_type => '::Host::Discovered'
        end

        #apipie_documented_controllers ["#{ForetelloApiV21::Engine.root}/app/controllers/api/v21/*.rb"]
      end
    end

  end
end

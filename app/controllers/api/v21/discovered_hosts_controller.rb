module Api
  module V21
    class DiscoveredHostsController < V2::DiscoveredHostsController

      include Api::Version21

      def index
        super
        render :json => @discovered_hosts, :each_serializer => DiscoveredHostSerializer
      end

      def show
        render :json => @discovered_host, :serializer => DiscoveredHostSerializer
      end

      # using rename rather than update since PUT update started the provision
      # TODO add functional test
      def rename
        not_found and return false if params[:id].blank?
        @discovered_host = ::Host::Discovered.find(params[:id])
        @discovered_host.update_attribute(:name, params[:discovered_host][:name])
        render :json => @discovered_host, :serializer => DiscoveredHostSerializer
      end

      private

      def action_permission
        case params[:action]
        when 'rename'
          :edit
        else
          super
      end
  end


    end
  end
end

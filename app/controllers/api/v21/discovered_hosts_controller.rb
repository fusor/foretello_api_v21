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

    end
  end
end

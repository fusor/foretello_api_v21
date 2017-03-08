module Api
  module V21
    class DiscoveredHostsController < V2::DiscoveredHostsController

      include Api::Version21

      api :GET, "/discovered_hosts/", N_("List all discovered hosts")
      param :search, String, :desc => N_("filter results")
      param :order, String, :desc => N_("sort results")
      param :page, String, :desc => N_("paginate results")
      param :per_page, String, :desc => N_("number of entries per request")

      def index
        super
        @discovered_hosts = @discovered_hosts.where(:id => params[:id]) if params[:id].present?
        render :json => @discovered_hosts, :each_serializer => HostBaseSerializer, :serializer => RootArraySerializer
      end

      api :GET, "/discovered_hosts/:id/", N_("Show a discovered host")
      param :id, :identifier_dottable, :required => true

      def show
        render :json => @discovered_host, :serializer => HostBaseSerializer
      end

      api :PUT, "/discovered_hosts/:id/rename", N_("Rename a discovered host")
      param :id, :identifier_dottable, :required => true
      param :discovered_host, Hash, :action_aware => true do
        param :name, String
      end

      # using rename rather than update since PUT update started the provision
      # TODO add functional test
      def rename
        not_found and return false if params[:id].blank?
        @discovered_host = ::Host::Discovered.find(params[:id])
        @discovered_host.update_attributes!(:name => params[:discovered_host][:name])
        render :json => @discovered_host, :serializer => HostBaseSerializer
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

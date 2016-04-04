module Api
  module V21
    class HostsController < V2::HostsController

      include Api::Version21

      def index
        super
        @hosts = @hosts.where(:id => params[:id]) if params[:id].present?
        render :json => @hosts, :each_serializer => HostBaseSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @host, :serializer => HostBaseSerializer
      end

    end
  end
end


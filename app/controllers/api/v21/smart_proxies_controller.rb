module Api
  module V21
    class SmartProxiesController < V21::BaseController

      include Api::Version21

      def index
        super
        render :json => @smart_proxies, :each_serializer => SmartProxySerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @smart_proxy, :serializer => SmartProxySerializer
      end

    end
  end
end

module Api
  module V21
    class SubnetsController < V2::SubnetsController

      include Api::Version21

      def index
        super
        render :json => @subnets, :each_serializer => SubnetSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @subnet, :serializer => SubnetSerializer
      end

    end
  end
end

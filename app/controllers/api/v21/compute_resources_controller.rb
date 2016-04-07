module Api
  module V21
    class ComputeResourcesController < V2::ComputeResourcesController

      include Api::Version21

      def index
        super
        render :json => @compute_resources, :each_serializer => ComputeResourceSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @compute_resource, :serializer => ComputeResourceSerializer
      end

    end
  end
end

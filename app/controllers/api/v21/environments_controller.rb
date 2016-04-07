module Api
  module V21
    class EnvironmentsController < V2::EnvironmentsController

      include Api::Version21

      def index
        super
        render :json => @environments, :each_serializer => EnvironmentSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @environment, :serializer => EnvironmentSerializer
      end

    end
  end
end

module Api
  module V21
    class ParametersController < V2::ParametersController

      include Api::Version21

      def index
        super
        render :json => @parameters, :each_serializer => ParameterSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @parameter, :serializer => ParameterSerializer
      end

    end
  end
end

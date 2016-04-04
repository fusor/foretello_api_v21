module Api
  module V21
    class CommonParametersController < V2::CommonParametersController

      include Api::Version21

      def index
        super
        render :json => @common_parameters, :each_serializer => ParameterSerializer, :serializer => RootArraySerializer
      end


      def show
        render :json => @common_parameter, :serializer => ParameterSerializer
      end

    end
  end
end

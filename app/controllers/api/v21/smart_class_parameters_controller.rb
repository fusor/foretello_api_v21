module Api
  module V21
    class SmartClassParametersController < V2::SmartClassParametersController

      include Api::Version21

      def index
        super
        render :json => @smart_class_parameters, :each_serializer => SmartClassParameterSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @smart_class_parameter, :serializer => SmartClassParameterSerializer
      end

    end
  end
end

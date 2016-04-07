module Api
  module V21
    class SmartVariablesController < V2::SmartVariablesController

      include Api::Version21

      def index
        super
        render :json => @smart_variables, :each_serializer => SmartVariableSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @smart_variable, :serializer => SmartVariableSerializer
      end

    end
  end
end

module Api
  module V21
    class PtablesController < V2::PtablesController

      include Api::Version21

      def index
        super
        render :json => @ptables, :each_serializer => PtableSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @ptable, :serializer => PtableSerializer
      end

    end
  end
end

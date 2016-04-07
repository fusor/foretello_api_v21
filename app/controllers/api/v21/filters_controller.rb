module Api
  module V21
    class FiltersController < V21::BaseController

      include Api::Version21

      def index
        super
        render :json => @filters, :each_serializer => FilterSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @filter, :serializer => FilterSerializer
      end

    end
  end
end

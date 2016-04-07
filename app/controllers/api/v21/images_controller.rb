module Api
  module V21
    class ImagesController < V2::ImagesController

      include Api::Version21

      def index
        super
        render :json => @images, :each_serializer => ImageSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @image, :serializer => ImageSerializer
      end

    end
  end
end

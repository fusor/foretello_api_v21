module Api
  module V21
    class RealmsController < V2::RealmsController

      include Api::Version21

      def index
        super
        render :json => @realms, :each_serializer => RealmSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @realm, :serializer => RealmSerializer
      end

    end
  end
end

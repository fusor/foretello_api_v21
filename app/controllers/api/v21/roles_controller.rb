module Api
  module V21
    class RolesController < V2::RolesController

      include Api::Version21

      def index
        super
        render :json => @roles, :each_serializer => RoleSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @role, :serializer => RoleSerializer
      end

    end
  end
end

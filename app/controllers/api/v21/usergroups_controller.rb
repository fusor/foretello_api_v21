module Api
  module V21
    class UsergroupsController < V2::UsergroupsController

      include Api::Version21

      def index
        super
        render :json => @usergroups, :each_serializer => UsergroupSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @usergroup, :serializer => UsergroupSerializer
      end

    end
  end
end

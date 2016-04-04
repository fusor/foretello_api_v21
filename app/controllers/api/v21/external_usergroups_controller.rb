module Api
  module V21
    class ExternalUsergroupsController < V2::ExternalUsergroupsController

      include Api::Version21

      def index
        super
        render :json => @external_usergroups, :each_serializer => UsergroupSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @external_usergroups, :serializer => UsergroupSerializer
      end

    end
  end
end


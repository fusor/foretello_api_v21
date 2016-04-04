module Api
  module V21
    class ConfigGroupsController < V2::ConfigGroupsController

      include Api::Version21

      def index
        super
        render :json => @config_groups, :each_serializer => ConfigGroupSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @config_group, :serializer => ConfigGroupSerializer
      end

    end
  end
end

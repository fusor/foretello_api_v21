module Api
  module V21
    class ConfigTemplatesController < V2::ConfigTemplatesController

      include Api::Version21

      def index
        super
        render :json => @config_templates, :each_serializer => ConfigTemplateSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @config_template, :serializer => ConfigTemplateSerializer
      end

    end
  end
end

module Api
  module V21
    class OperatingsystemsController < V21::BaseController

      before_filter :find_resource, :only => %w{show edit update destroy bootfiles}

      def index
        @operatingsystems = Operatingsystem.
          authorized(:view_operatingsystems).
          includes(:media, :architectures, :ptables, :config_templates, :os_default_templates).
          search_for(*search_options).paginate(paginate_options)
      end

      def show
      end

      def create
        @operatingsystem = Operatingsystem.new(params[:operatingsystem])
        process_response @operatingsystem.save
      end

      def update
        process_response @operatingsystem.update_attributes(params[:operatingsystem])
      end

      def destroy
        process_response @operatingsystem.destroy
      end

      def bootfiles
        medium = Medium.authorized(:view_media).find_by_name(params[:medium])
        arch   = Architecture.authorized(:view_architectures).find_by_name(params[:architecture])
        render :json => @operatingsystem.pxe_files(medium, arch)
      rescue => e
        render :json => e.to_s, :status => :unprocessable_entity
      end

      protected

      def resource_identifying_attributes
        %w(to_label id)
      end

    end
  end
end

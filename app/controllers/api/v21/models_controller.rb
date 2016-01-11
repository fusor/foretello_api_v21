module Api
  module V21
    class ModelsController < V21::BaseController
      before_filter :find_resource, :only => %w{show update destroy}

      def index
        @models = Model.
          authorized(:view_models).
          search_for(*search_options).
          paginate(paginate_options)
      end

      def show
      end

      def create
        @model = Model.new(params[:model])
        process_response @model.save
      end

      def update
        process_response @model.update_attributes(params[:model])
      end

      def destroy
        process_response @model.destroy
      end
    end
  end
end

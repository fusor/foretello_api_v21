module Api
  module V21
    class ForemanTasksController < ::ForemanTasks::Api::TasksController

      include Api::Version21

      def index
        @foreman_tasks = ForemanTasks::Task.search_for(params[:search]).select('DISTINCT foreman_tasks_tasks.*')

        ordering_params =  {
                             sort_by: params[:sort_by] || 'started_at',
                             sort_order: params[:sort_order] || 'DESC'
                           }
        @foreman_tasks = ordering_scope(@foreman_tasks, ordering_params)


        pagination_params = {
                              page: params[:page] || 1,
                              per_page: params[:per_page] || 20
                            }
        @foreman_tasks = pagination_scope(@foreman_tasks, pagination_params)

        render :json => @foreman_tasks, :each_serializer => ForemanTaskSerializer, :serializer => RootArraySerializer
      end

      def show
        @foreman_task = ForemanTasks::Task.find(params[:id])
        render :json => @foreman_task, :serializer => ForemanTaskSerializer
      end

    end
  end
end

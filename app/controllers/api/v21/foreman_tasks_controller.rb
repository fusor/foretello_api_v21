module Api
  module V21
    class ForemanTasksController < ::ForemanTasks::Api::TasksController

      include Api::Version21

      api :GET, '/tasks', N_("List tasks")
      param :search, String, :desc => N_("Search string")
      param :page, :number, :desc => N_("Page number, starting at 1")
      param :per_page,  :number, :desc => N_("Number of results per page to return")
      param :order, String, :desc => N_("Sort field and order, eg. 'name DESC'")
      param :sort, Hash, :desc => N_("Hash version of 'order' param") do
        param :by, String, :desc => N_("Field to sort the results on")
        param :order, String, :desc => N_("How to order the sorted results (e.g. ASC for ascending)")
      end

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


      api :GET, "/tasks/:id", "Show task details"
      param :id, :identifier, desc: "UUID of the task"

      def show
        @foreman_task = ForemanTasks::Task.find(params[:id])
        render :json => @foreman_task, :serializer => ForemanTaskSerializer
      end

    end
  end
end

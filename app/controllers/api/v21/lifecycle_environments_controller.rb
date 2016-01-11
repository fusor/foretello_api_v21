module Api
  module V21
    class LifecycleEnvironmentsController < Api::V21::BaseController

      include Api::Version21

      before_filter :find_organization, :only => [:index, :create, :show, :update, :destroy]
      before_filter :find_lifecycle_environment, :only => [:show, :update, :destroy]

      api :GET, "/lifecycle_environments/", N_("List of lifecycle environments in an organization")
      param :organization_id, :number, :desc => N_("organization identifier"), :required => true
      param_group :search_and_pagination, ::Api::V2::BaseController

      def index
        @lifecycle_environments = ::Katello::KTEnvironment.readable.where(:organization_id => @organization.id)
        render :json => @lifecycle_environments, :each_serializer => LifecycleEnvironmentSerializer
      end

      api :GET, "/lifecycle_environments/:id/", N_("Show a lifecycle environment")
      param :id, :number, :desc => N_("ID of the environment"), :required => true
      param :organization_id, :number, :desc => N_("ID of the organization")

      def show
        render :json => @lifecycle_environment, :serializer => LifecycleEnvironmentSerializer
      end

      def_param_group :lifecycle_environment do
        param :lifecycle_environment, Hash, :required => true, :action_aware => true do
          param :name, String, :desc => N_("name of the environment"), :required => true
          param :label, String, :desc => N_("label of the environment"), :required => false
          param :description, String, :desc => N_("description of the environment")
          param :prior_id, Integer, :required => true, :desc => <<-DESC
            ID of an environment that is prior to the new environment in the chain. It has to be
            either the ID of Library or the ID of an environment at the end of a chain.
          DESC
        end
      end

      api :POST, "/lifecycle_environments/", N_("Create a lifecycle environment")
      param :organization_id, :number, :desc => N_("ID of the organization")
      param_group :lifecycle_environment, :as => :create


      def create
        @lifecycle_environment = ::Katello::KTEnvironment.new(environment_params)
        if @lifecycle_environment.save
          ## Add environment to Org
          #@organization.kt_environments << @environment
          #@organization.save!
          render :json => @lifecycle_environment, :serializer => LifecycleEnvironmentSerializer
        else
          render json: {errors: @lifecycle_environment.errors}, status: 422
        end
      end

      api :PUT, "/lifecycle_environments/:id", N_("Update a lifecycle environment")
      param :id, :number, :desc => N_("ID of the environment"), :required => true
      param :organization_id, :number, :desc => N_("ID of the organization")
      param_group :lifecycle_environment, :as => :update

      def update
        if @lifecycle_environment.save
          ## Add environment to Org
          #@organization.kt_environments << @environment
          #@organization.save!
          render :json => @lifecycle_environment, :serializer => LifecycleEnvironmentSerializer
        else
          render json: {errors: @lifecycle_environment.errors}, status: 422
        end
      end

      private

      def find_lifecycle_environment
        @lifecycle_environment = ::Katello::KTEnvironment.find_by_id(params[:id])
        return @lifecycle_environment if @lifecycle_environment
        return :json => {:error => "Couldn't find organization" }
      end

      def find_organization
        @organization = ::Organization.find_by_id(params[:organization_id])
        return @organization if @organization
        return :json => {:error => "Couldn't find organization" }
      end

      def environment_params
        attrs = [:name, :description, :organization_id, :label, :prior]
        parms = params.require(:lifecycle_environment).permit(*attrs)
        parms
      end

    end
  end
end

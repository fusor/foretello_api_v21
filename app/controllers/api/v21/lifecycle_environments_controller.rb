module Api
  module V21
    class LifecycleEnvironmentsController < Api::V21::BaseController

      include Api::Version21

      before_filter :find_organization, :only => [:index, :create, :show, :update, :destroy]
      before_filter :find_lifecycle_environment, :only => [:show, :update, :destroy]

      def index
        @lifecycle_environments = ::Katello::KTEnvironment.readable.where(:organization_id => @organization.id)
        render :json => @lifecycle_environments, :each_serializer => LifecycleEnvironmentSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @lifecycle_environment, :serializer => LifecycleEnvironmentSerializer
      end

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

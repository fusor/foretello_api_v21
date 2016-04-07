module Api
  module V21
    class OrganizationsController < V2::OrganizationsController

      include Api::Version21

      def index
        # could not call super, since v2 calls render
        if @nested_obj
          #@taxonomies = @domain.locations.search_for(*search_options).paginate(paginate_options)
          @taxonomies = @nested_obj.send(taxonomies_plural).search_for(*search_options).paginate(paginate_options)
          @total = @nested_obj.send(taxonomies_plural).count
        else
          @taxonomies = taxonomy_class.search_for(*search_options).paginate(paginate_options)
          @total = taxonomy_class.count
        end
        instance_variable_set("@#{taxonomies_plural}", @taxonomies)
        render :json => @organizations, :each_serializer => OrganizationSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @organization, :serializer => OrganizationSerializer
      end

      def create
        @organization = Organization.new(params[:organization])
        if @organization.save
          render :json => @organization, :serializer => OrganizationSerializer
        else
          render json: {errors: @organization.errors}, status: 422
        end
      end

    end
  end
end

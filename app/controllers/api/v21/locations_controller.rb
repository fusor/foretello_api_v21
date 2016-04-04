module Api
  module V21
    class LocationsController < V2::LocationsController

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
        render :json => @locations, :each_serializer => LocationSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @location, :serializer => LocationSerializer
      end

    end
  end
end

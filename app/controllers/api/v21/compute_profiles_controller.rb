module Api
  module V21
    class ComputeProfilesController < V2::ComputeProfilesController

      include Api::Version21

      def index
        super
        render :json => @compute_profiles, :each_serializer => ComputeProfileSerializer, :serializer => RootArraySerializer
      end

      def show
        render :json => @compute_profile, :serializer => ComputeProfileSerializer
      end

    end
  end
end



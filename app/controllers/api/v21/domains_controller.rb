module Api
  module V21
    class DomainsController < V2::DomainsController

      include Api::Version21

      api :GET, "/domains/", N_("List of domains")

      def index
        super
        render :json => @domains, :each_serializer => DomainSerializer
      end

      api :GET, "/domains/:id/", N_("Show a domain")
      param :id, :identifier, :required => true, :desc => N_("Numerical ID or domain name")

      def show
        render :json => @domain, :serializer => DomainSerializer
      end

    end
  end
end

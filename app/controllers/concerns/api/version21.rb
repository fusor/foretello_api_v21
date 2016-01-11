module Api
  module Version21
    extend ActiveSupport::Concern


    included do
      resource_description do
        api_version "v21"
        app_info N_("Foretello v21 is experimental. You may use v21 by either passing 'version=21' in the Accept Header or using api/v21/ in the URL.")
      end
    end

    def api_version
      '21'
    end

  end
end
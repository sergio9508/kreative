#
module Latte
  #
  class ServicesController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable
    #

    def model
      Service
    end

    def permits
      [:enabled, :priority, :name, :slug, :description, :service_name]
    end

    def exportable_fields
      %i[enabled priority name description]
    end

  end
end

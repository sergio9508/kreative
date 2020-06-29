module Latte
  class ServiceCategoriesController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable

    def model
      ServiceCategory
    end

    def permits
      %i[name description service_id enabled slug]
    end

    def exportable_fields
      %i[name desciption service_id enabled slug]
    end

    def init_form
      @service = Service.order :name
    end
  end
end
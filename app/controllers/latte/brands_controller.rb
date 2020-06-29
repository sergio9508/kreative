module Latte
  class BrandsController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable

    def model
      Brand
    end

    def permits
      %i[name description]
    end

    def exportable_fields
      %i[name description]
    end
  end
end

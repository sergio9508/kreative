module Latte
  class PortfoliosController < LatteController
    include Latte::Multiple
    include Latte::Crud
    include Latte::CsvExportable

    def model
      Portfolio
    end

    def permits
      %i[enabled name description slug client brand in_home category]
    end

    def exportable_fields
      %i[enabled name description slug]
    end
  end
end

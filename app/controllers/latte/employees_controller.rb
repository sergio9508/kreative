module Latte
  class EmployeesController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable

    def model
      Employee
    end

    def permits
      %i[first_name last_name job linkedin]
    end
    
    def exportable_fields
      %i[first_name last_name job linkedin]
    end

  end
  
end

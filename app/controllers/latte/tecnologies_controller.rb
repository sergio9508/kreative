module Latte
  class TecnologiesController < LatteController
    include Latte::Crud
    include Latte::Multiple
    
    def model
      Tecnology
    end

    def permits
      [:name]
    end
  end
end

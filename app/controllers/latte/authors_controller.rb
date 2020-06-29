module Latte
  class AuthorsController < LatteController
    include Latte::Crud
    include Latte::Multiple

    def model
      Author
    end
  end
end

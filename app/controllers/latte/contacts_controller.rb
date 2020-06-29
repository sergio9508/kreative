#
module Latte
  #
  class ContactsController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable
    #

    def model
      Contact
    end

    def permits
      %i[name email phone content]
    end

    def exportable_fields
      %i[enabled priority in_header in_footer name description content]
    end

    def init_form
      @countries = Country.order :name
    end
  end
end

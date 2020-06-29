#
module Latte
    #
    class CountriesController < LatteController
      include Latte::Crud
      include Latte::Multiple
      include Latte::CsvExportable
      #
  
      def model
        Country
      end

      def permits
        %i[name priority]
      end
  
      def list
        render json: policy_scope(model)
          .where(id: Contact.pluck(:country_id))
          .select(:id, model.acts_as_label)
          .order(model.acts_as_label)
          .to_json
      end

    end
end
  
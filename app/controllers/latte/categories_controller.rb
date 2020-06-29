#
module Latte
  #
  class CategoriesController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable
    #

    def model
      Category
    end

    def init_form
      @categories = Category.where(category_id: nil)
                            .where.not(id: @item.try(:id))
    end

    def permits
      [:name, :category_id, :enabled, :priority, :in_header, :in_footer,
       :description, :content, :slug, item_ids: []]
    end

    def exportable_fields
      %i[name category_id enabled priority in_header in_footer description
         content]
    end
  end
end

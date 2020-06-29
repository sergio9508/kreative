#
module Latte
  #
  class AboutsController < LatteController
    include Latte::Crud

    def model
      About
    end

    def edit_url
      edit_latte_abouts_url
    end

    def breadcrumbs_for(action)
      add_breadcrumb t('home'), latte_root_url
      add_breadcrumb t(action.to_s), nil
    end

    def permits
      %i[description content year proyect_count summary]
    end

    def set_item
      @item = About.first
    end
  end
end

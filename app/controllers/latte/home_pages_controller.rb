#
module Latte
  #
  class HomePagesController < LatteController
    include Latte::Crud

    def model
      HomePage
    end

    def edit_url
      edit_latte_home_pages_url
    end

    def breadcrumbs_for(action)
      add_breadcrumb t('home'), latte_root_url
      add_breadcrumb t(action.to_s), nil
    end

    def permits
      %i[name subtitle services projects whyus ourprocess brands]
    end

    def init_form
      # @pages = Page.order :name
    end

    def set_item
      @item = HomePage.first
    end
  end
end

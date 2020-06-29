module Latte
  class ArticlesController < LatteController
    include Latte::Crud
    include Latte::Multiple
    include Latte::CsvExportable

    def model
      Article
    end

    def permits
      [:enabled, :priority, :in_home, :name, :summary,
       :content, :slug, :published_at, :category]
    end

    def json_methods
      %i[can_destroy can_update translated_locales]
    end
  end
end

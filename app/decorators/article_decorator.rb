class ArticleDecorator < Draper::Decorator
  delegate_all

  def translated_locales
    x = I18n.available_locales.select do |o|
      object.translations.where(locale: o).exists?
    end

    x.map { |o| "<em>#{o}</em>" }.join
  end
  
end

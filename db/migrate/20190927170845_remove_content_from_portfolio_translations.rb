class RemoveContentFromPortfolioTranslations < ActiveRecord::Migration[5.0]
  def change
    remove_column :portfolio_translations, :content, :text
  end
end

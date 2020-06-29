class AddCategoryToPortfolio < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :category, :string
  end
end

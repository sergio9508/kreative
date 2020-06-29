class AddBrandToPortfolio < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :brand, :string
  end
end

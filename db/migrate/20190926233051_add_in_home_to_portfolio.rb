class AddInHomeToPortfolio < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :in_home, :boolean
  end
end

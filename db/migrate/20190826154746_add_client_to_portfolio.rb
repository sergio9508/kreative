class AddClientToPortfolio < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :client, :string
  end
end

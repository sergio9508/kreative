class RemoveTypeFromPortfolio < ActiveRecord::Migration[5.0]
  def change
    remove_column :portfolios, :type, :string
  end
end

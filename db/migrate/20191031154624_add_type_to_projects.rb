class AddTypeToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :type, :string
  end
end

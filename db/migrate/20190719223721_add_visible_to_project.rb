class AddVisibleToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :visible, :boolean
  end
end

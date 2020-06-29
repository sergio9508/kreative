class AddEnabledToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :enabled, :boolean
  end
end

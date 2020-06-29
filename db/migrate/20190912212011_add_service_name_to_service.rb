class AddServiceNameToService < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :service_name, :string
  end
end

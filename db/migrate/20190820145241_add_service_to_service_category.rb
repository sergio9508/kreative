class AddServiceToServiceCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :service_categories, :service, foreign_key: true
  end
end

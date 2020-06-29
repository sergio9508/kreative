class AddLinkedinToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :linkedin, :string
  end
end

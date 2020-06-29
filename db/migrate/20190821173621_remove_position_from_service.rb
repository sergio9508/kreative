class RemovePositionFromService < ActiveRecord::Migration[5.0]
  def change
    remove_column :services, :position, :string
  end
end

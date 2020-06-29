class AddCountryToContact < ActiveRecord::Migration[5.0]
  def change
    add_reference :contacts, :country, foreign_key: true
  end
end

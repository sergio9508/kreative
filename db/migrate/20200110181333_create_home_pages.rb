class CreateHomePages < ActiveRecord::Migration[5.0]
  def change
    create_table :home_pages do |t|
      t.string :name
      t.string :subtitle
      t.text :services
      t.text :projects
      t.text :whyus
      t.text :ourprocess
      t.text :brands

      t.timestamps
    end
  end
end

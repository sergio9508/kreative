class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :website_url
      t.string :twitter_url
      t.string :facebook_url

      t.timestamps
    end
  end
end

class AddPublishedAtToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :published_at, :timestamp
  end
end

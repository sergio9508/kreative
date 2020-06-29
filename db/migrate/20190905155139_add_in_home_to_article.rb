class AddInHomeToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :in_home, :boolean
  end
end

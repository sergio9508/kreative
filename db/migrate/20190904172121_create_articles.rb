class CreateArticles < ActiveRecord::Migration[5.0]
  def up
    create_table :articles do |t|
      t.boolean :enabled
      t.references :authors, foreign_key: true
      t.timestamps
    end
      Article.create_translation_table! name: :string,
                                        category: :string,
                                        summary: :text,
                                        content: :text,
                                        slug: {
                                          type: :string,
                                          index: true,
                                          unique: true
                                        }
  end
  def down
    Article.drop_translation_table!
    drop_table :articles
  end
end

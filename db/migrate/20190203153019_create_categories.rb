class CreateCategories < ActiveRecord::Migration[5.0]
  def up
    create_table :categories do |t|
      t.references :category, foreign_key: true
      t.boolean :enabled
      t.boolean :in_header
      t.boolean :in_footer
      t.integer :priority

      t.timestamps
    end

    Category.create_translation_table! name: :string,
                                       description: :text,
                                       content: :text,
                                       slug: {
                                         type: :string,
                                         index: true,
                                         unique: true
                                       }
  end

  def down
    Category.drop_translation_table!
    drop_table :categories
  end
end

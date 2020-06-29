class CreateAbouts < ActiveRecord::Migration[5.0]
  def up
    create_table :abouts do |t|
      t.integer :year
      t.integer :proyect_count
      t.timestamps
    end
    About.create_translation_table! content: :text,
                                    description: :text,
                                    summary: :text
  end
  def down
    About.drop_translation_table!
    drop_table :abouts
  end
end

class CreateServiceCategories < ActiveRecord::Migration[5.0]
  def up
    create_table :service_categories do |t|
      t.boolean :enabled, null: false, default: false
      t.timestamps
    end
    ServiceCategory.create_translation_table! name: :string,
                                              description: :text,
                                              slug: {
                                                type: :string,
                                                index: true,
                                                unique: true
                                              }
      
  end
  def down
    ServiceCategory.drop_translation_table!
    drop_table :service_categories
  end
end

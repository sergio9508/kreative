class CreateServices < ActiveRecord::Migration[5.0]
  def up
    create_table :services do |t|

      t.integer :priority
      t.integer :position
      t.timestamps
    end
      Service.create_translation_table! name: :string,
                                        description: :text,
                                        slug: {
                                          type: :string,
                                          index: true,
                                          unique: true
                                        }
  end
  def down
    Service.drop_translation_table!
    drop_table :services
  end
end

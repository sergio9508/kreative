class CreatePortfolios < ActiveRecord::Migration[5.0]
  def up
    create_table :portfolios do |t|
      t.boolean :enabled
      t.timestamps
    end
    Portfolio.create_translation_table! name: :string,
                                        description: :text,
                                        type: :string,
                                        slug: {
                                                type: :string,
                                                index: true,
                                                unique: true
                                              }
  end
  def down
    Portfolio.drop_translation_table!
    drop_table :portfolios
  end
end

class CreateTecnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :tecnologies do |t|
      t.string :name

      t.timestamps
    end
  end
end

class CreateSengas < ActiveRecord::Migration[5.1]
  def change
    create_table :sengas do |t|
      t.references :user, foreign_key: true
      t.string :image
      t.string :tittle
      t.text :description

      t.timestamps
    end
  end
end

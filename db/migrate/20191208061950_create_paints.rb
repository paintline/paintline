class CreatePaints < ActiveRecord::Migration[5.1]
  def change
    create_table :paints do |t|
      t.references :user, foreign_key: true
      t.references :senga, foreign_key: true
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end

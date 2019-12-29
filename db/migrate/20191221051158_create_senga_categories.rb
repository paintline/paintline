class CreateSengaCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :senga_categories do |t|
      t.references :senga, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

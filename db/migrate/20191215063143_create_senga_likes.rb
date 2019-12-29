class CreateSengaLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :senga_likes do |t|
      t.references :user, foreign_key: true
      t.references :senga, foreign_key: true

      t.timestamps
    end
  end
end

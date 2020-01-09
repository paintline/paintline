class CreatePaintLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :paint_likes do |t|
      t.references :user, foreign_key: true
      t.references :paint, foreign_key: true

      t.timestamps
    end
  end
end

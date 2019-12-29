class CreateSengaRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :senga_requests do |t|
      t.references :user, foreign_key: true
      t.references :senga, foreign_key: true
      t.boolean :permission

      t.timestamps
    end
  end
end

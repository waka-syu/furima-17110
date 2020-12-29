class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.text    :status_message
      t.integer :prefecture_id,         null: false
      t.integer :gender_id,             null: false
      t.references :user,               null: false, foreign_key: true
      t.timestamps
    end
  end
end

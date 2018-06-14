class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid, limit: 256, null: false
      t.string :password_digest, limit: 256, null: false

      t.timestamps
    end

    add_index :users, :uid
  end
end

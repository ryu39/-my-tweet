class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :text, limit: 140, null: false
      t.string :url, limit: 1000

      t.timestamps
    end
  end
end

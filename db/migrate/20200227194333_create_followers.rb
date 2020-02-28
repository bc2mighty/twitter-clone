class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.string :following_id
      t.string :follower_id
      t.references :user, null: false, foreign_key: true
      t.string :user_string_id

      t.timestamps
    end
  end
end

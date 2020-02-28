class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :tweeter_id
      t.references :user, null: false, foreign_key: true
      t.string :user_string_id
      t.text :tweet

      t.timestamps
    end
  end
end

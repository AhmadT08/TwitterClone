class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content
      t.integer :likes
      t.integer :dislikes

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "username"

      t.string "gender"
      t.string "seeking"

      t.integer :daily_interactions_remaining
    end
  end
end

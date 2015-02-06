class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :aasm_state
    end
  end
end
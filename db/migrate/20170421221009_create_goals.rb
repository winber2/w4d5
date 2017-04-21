class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.boolean :goal_status, null: false, default: false
      t.string :name, null: false
      t.text :body
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :goals, :user_id
  end
end

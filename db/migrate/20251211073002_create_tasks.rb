class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description
      t.string :status, null: false, default: "ongoing"
      t.datetime :start_time
      t.datetime :end_time
      t.integer :priority, default: 2

      t.timestamps
    end
  end
end

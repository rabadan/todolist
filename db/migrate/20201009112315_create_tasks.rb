class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :text
      t.boolean :is_closed, default: false, null: false

      t.timestamps
    end
    add_index :tasks, :is_closed
  end
end

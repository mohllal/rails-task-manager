class CreateTaskUserAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :task_user_assignments do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role
      
      t.index [:task_id, :user_id]
      t.index [:user_id, :task_id]

      t.timestamps
    end
  end
end

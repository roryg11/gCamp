class AddDueDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due_date, :date
    add_column :tasks, :complete, :boolean
  end
end

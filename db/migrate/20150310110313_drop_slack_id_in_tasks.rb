class DropSlackIdInTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :slack_id
  end
end

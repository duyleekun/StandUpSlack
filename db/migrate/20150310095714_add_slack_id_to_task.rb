class AddSlackIdToTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :username
    add_column :tasks, :user_id, :integer
    add_column :tasks, :slack_id, :string
  end
end

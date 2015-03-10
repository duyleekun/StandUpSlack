class AddSlackIdToTask < ActiveRecord::Migration
  def change
    rename_column :tasks, :username, :user_id
    add_column :tasks, :slack_id, :string
  end
end

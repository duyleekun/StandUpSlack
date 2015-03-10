class AddStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :daily_prompt_active, :boolean, default: true
  end
end

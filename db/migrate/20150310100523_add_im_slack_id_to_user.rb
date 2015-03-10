class AddImSlackIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :im_slack_id, :string
  end
end

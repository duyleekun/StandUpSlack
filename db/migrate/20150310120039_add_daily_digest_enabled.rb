class AddDailyDigestEnabled < ActiveRecord::Migration
  def change
    add_column :users, :daily_digest_enabled, :boolean, default: true
  end
end

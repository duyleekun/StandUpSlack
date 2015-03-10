class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.text :real_name
      t.integer :team_id
      t.string :slack_id

      t.timestamps
    end
  end
end

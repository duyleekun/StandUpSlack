class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.text :name
      t.string :token
      t.string :slack_id

      t.timestamps
    end
  end
end

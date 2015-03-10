class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.string :username
      t.integer :type

      t.timestamps
    end
  end
end

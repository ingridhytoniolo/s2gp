class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :status
      t.string :title
      t.string :slug
      t.string :main_goal
      t.text :description
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end

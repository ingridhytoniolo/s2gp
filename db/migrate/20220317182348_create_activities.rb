class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.belongs_to :project, foreign_key: true
      t.string :status
      t.text :description
      t.string :priority
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end

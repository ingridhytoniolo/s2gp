class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :profile, foreign_key: true
      t.belongs_to :project, foreign_key: true
      t.string :status
      t.string :role

      t.timestamps
    end
  end
end

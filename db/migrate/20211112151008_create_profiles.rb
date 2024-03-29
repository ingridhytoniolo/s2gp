class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :role
      t.string :lattes_url

      t.timestamps
    end
  end
end

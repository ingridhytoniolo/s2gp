class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :profile
      t.string :title
      t.string :description
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end

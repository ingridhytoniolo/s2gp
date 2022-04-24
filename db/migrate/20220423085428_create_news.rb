class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.references :profile
      t.string :title
      t.string :description
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end

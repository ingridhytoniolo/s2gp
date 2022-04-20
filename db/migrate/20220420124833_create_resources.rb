class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :kind
      t.string :name
      t.text :description
      t.string :code
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end

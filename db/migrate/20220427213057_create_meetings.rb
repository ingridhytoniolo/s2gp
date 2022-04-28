class CreateMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :meetings do |t|
      t.references :profile
      t.boolean :public
      t.references :project
      t.string :title
      t.string :description
      t.datetime :date
      t.string :location
      t.string :streaming_url

      t.timestamps
    end
  end
end

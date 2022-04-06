class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.references :participating, polymorphic: true, null: false, index: true
      t.references :profile, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end

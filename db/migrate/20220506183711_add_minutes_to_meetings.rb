class AddMinutesToMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :meetings, :minutes, :text
  end
end

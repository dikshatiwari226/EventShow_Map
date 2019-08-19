class CreateMeetingEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_events do |t|
    	t.string :title
    	t.datetime :start_date
    	t.datetime :end_date
    	t.text :summary
    	
      t.timestamps
    end
  end
end

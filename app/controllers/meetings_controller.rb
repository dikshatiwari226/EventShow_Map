class MeetingsController < ApplicationController
	def show
    # cal = Icalendar::Calendar.new

    # Event.all.each do |event|
    #   if event.start_date.present? && event.end_date.present?
    #   	ical_event = Icalendar::Event.new
    #     ical_event.dtstart = Icalendar::Values::Date.new(event.start_date.strftime('%Y%m%d'))
    #     ical_event.dtend   = Icalendar::Values::Date.new(event.end_date.strftime('%Y%m%d'))
    #     ical_event.summary = event.title
    #     cal.add_event(ical_event)
    #   end
    # end
    
    # puts "Event= #{cal.to_ical}"
    
    respond_to do |format|
      format.ics do
        cal = Icalendar::Calendar.new
        Event.all.each do |event|
          if event.start_date.present? && event.end_date.present?
            ical_event = Icalendar::Event.new
            ical_event.dtstart = Icalendar::Values::Date.new(event.start_date.strftime('%Y%m%d'))
            ical_event.dtend   = Icalendar::Values::Date.new(event.end_date.strftime('%Y%m%d'))
            ical_event.summary = event.title
            cal.add_event(ical_event)
          end 
        end         
        cal.publish 
      end
      format.html  
    end
  end

	# def to_icalendar
	# 	byebug
	# 	@event = MeetingEvent.all
	# 	respond_to do |format|
	# 		format.ics do
	# 			cal = Icalendar::Calendar.new
 #          event = Icalendar::Event.new
 #            # event.dtstart = @event.start_date
 #            # event.dtend = @event.end_date 
 #            event.summary = @event.title
 #            event.uid = event.url = "#{event_url}"
 #            cal.add_event(event)            
 #            cal.publish
            
	# 		end 
	# 	end
	
end

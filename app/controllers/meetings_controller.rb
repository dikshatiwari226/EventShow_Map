class MeetingsController < ApplicationController
	def show
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
        cal_string = cal.to_ical
        send_data cal_string, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=ical.ics"
      end
      format.html
    end
  end
end

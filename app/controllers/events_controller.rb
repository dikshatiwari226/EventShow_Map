class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # def search
  #   @event_paginator = EventMap.paginate(page: params[:page], per_page:1)
  # end

  # GET /events
  # GET /events.json
  #

  

  # => Events direction details GET /events/:id/allevent_details
  
  def allevent_details
     @event_details = Event.find(params[:id])
     @map_data = [[ @event_details.title,  @event_details.latitude, @event_details.longitude, @event_details.description, @event_details.city, @event_details.state, @event_details.id]]

  end
  
  def index
    if params[:search].present?
      @events = Event.where("lower(title) LIKE :prefix OR lower(address) LIKE :prefix", prefix: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 2)
    elsif params[:category_id].present?
      @events = Event.where(category_id: params[:category_id]).paginate(page: params[:page], per_page: 2)
    else
      @events = Event.all.paginate(page: params[:page], per_page: 2)
    end
      @map_data = @events.map{|e| [ e.title,  e.latitude, e.longitude, e.description, e.city, e.state, e.id]}
      
      @upcoming_events = Event.where("start_date > ?",  DateTime.now).paginate(page: params[:page], per_page: 2)
      @expired_events =  Event.where("start_date < ?",  DateTime.now).paginate(page: params[:page], per_page: 2)
      @categories = Category.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save!
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def generate_ical
    cal = Icalendar::Calendar.new
    @events.find_each do |eventcal|
      # create the event for this tool
      event = Icalendar::Event.new
      event.start = eventcal.start_date.strftime("%Y%m%dT%H%M%S")
      event.end = eventcal.end_date.strftime("%Y%m%dT%H%M%S")
      event.summary = eventcal.title if eventcal.title
      # event.uid = eventcal_url(eventcal)
      
      # insert the event into the calendar
      cal.add event
    end
    
    # return the calendar as a string
    cal.to_ical
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :image, :address, :latitude, :longitude, :city, :state, :zip_code, :country, :start_date, :end_date, :category_id )
    end
end

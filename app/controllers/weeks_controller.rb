class WeeksController < ApplicationController
    
    respond_to :html, :js
    
    def create
         next_week_start = ((Week.find(params[:id]).start).to_datetime + 7).rfc3339()
        @week = Week.find_or_create_by(user_id: current_user.id, start: next_week_start) do |week|
            week.user_id = current_user.id  
            week.start = next_week_start
            week.end = ((Week.find(params[:id]).end).to_datetime + 7).rfc3339()
            week.prior_week = params[:id]
        end
        redirect_to user_week_path(user_id: current_user.id, id: @week.id)
    end
    
    def show
        @week = Week.find(params[:id])
        @events = events("primary", @week.start, @week.end).items
        @tasks = current_user.tasks
        7.times do |i|
            instance_variable_set("@day_events#{i}", @events.select{ |event| event.start.date == (@week.start.to_date + i).to_s || (if !(event.start.date_time.nil?) then event.start.date_time.to_date.to_s == (@week.start.to_date + i).to_s end)})
            instance_variable_set("@day_tasks#{i}", @tasks.where("date = ?", @week.start.to_date + i))
        end
        @todos = @tasks.where("todo = ?", true)    
    end
    
    def index
    end
    
    
end

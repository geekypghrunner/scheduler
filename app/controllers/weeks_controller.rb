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
        
        7.times do |i|
            Day.find_or_create_by(date: (@week.start.to_date + i).to_s, user_id: current_user.id) do |day|
                day.user_id = current_user.id
                day.week_id = @week.id
                day.date = (@week.start.to_date + i).to_s
            end
        end
        redirect_to user_week_path(user_id: current_user.id, id: @week.id)
    end
    
    def show
        @week = Week.find(params[:id])
        @events = events("primary", @week.start, @week.end).items
        @tasks = current_user.tasks
        @days = @week.days
        @incomplete_todos = @tasks.where("todo = ? AND completed = ?", true, false)
        @complete_todos = @tasks.where("todo = ? AND completed = ?", true, true )
    end
    
    def index
    end
    
    
end

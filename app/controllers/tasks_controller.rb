class TasksController < ApplicationController

  respond_to :html, :js

    
    def create
        @task = Task.create(:user_id => params[:user_id], :date => Date.strptime(params[:date], "%m/%d/%Y").to_s, :summary => params[:summary], :todo => params[:todo])
        @week = Week.find(params[:id])
        @events = events("primary", @week.start, @week.end).items
        @tasks = current_user.tasks
        7.times do |i|
            instance_variable_set("@day_events#{i}", @events.select{ |event| event.start.date == (@week.start.to_date + i).to_s || (if !(event.start.date_time.nil?) then event.start.date_time.to_date.to_s == (@week.start.to_date + i).to_s end)})
            instance_variable_set("@day_tasks#{i}", @tasks.where("date = ?", @week.start.to_date + i))
        end

#        redirect_to user_week_path(user_id: current_user.id, id: params[:id])
    end
    
    def new
    end
    
end

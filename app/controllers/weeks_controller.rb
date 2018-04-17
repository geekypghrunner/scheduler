class WeeksController < ApplicationController
    
    respond_to :html, :js
    before_action :authorized_user!
    
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
        @days = @week.days
        @tasks = current_user.tasks
        @incomplete_home_todos = @tasks.where("todo = ? AND completed = ? AND task_type = ?", true, false, "home")
        @complete_home_todos = @tasks.where("todo = ? AND completed = ? AND task_type = ?", true, true, "home" )
        @incomplete_work_todos = @tasks.where("todo = ? AND completed = ? AND task_type = ?", true, false, "work")
        @complete_work_todos = @tasks.where("todo = ? AND completed = ? AND task_type = ?", true, true, "work")
        @incomplete_buy_todos = @tasks.where("todo = ? AND completed = ? AND task_type = ?", true, false, "buy")
        @complete_buy_todos = @tasks.where("todo = ? AND completed = ? AND task_type = ?", true, true, "buy")
        @events = []
        current_user.cal_list.each do |calendar| 
            @events += events(calendar, @week.start, @week.end).items 
        end
        @events.sort! {|a,b| 
            if !(a.start.date_time.nil?) && !(b.start.date_time.nil?) 
                a.start.date_time <=> b.start.date_time
            elsif !(a.start.date_time.nil?) && !(b.start.date.nil?)
                a.start.date_time <=> b.start.date 
            elsif !(a.start.date.nil?) && !(b.start.date_time.nil?)
                a.start.date <=> b.start.date_time 
            else
                a.start.date <=> b.start.date
            end
        }
    end
    
    def index
    end
    

end

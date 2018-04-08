class TasksController < ApplicationController

  respond_to :html, :js

    before_action :modify_date_param, only: [:create]
    
    def create
        @task = Task.new(task_params)
        @task.completed = false
        @task.save
        @week = Week.find(params[:id])
        @events = events("primary", @week.start, @week.end).items
        @tasks = current_user.tasks
        @days = @week.days
        @incomplete_todos = @tasks.where("todo = ? AND completed = ?", true, false)
        @complete_todos = @tasks.where("todo = ? AND completed = ?", true, true)
    end
    
    def new
    end
   
   def update
        @task = Task.find(params[:id])
        @task.update(:completed => params[:task][:completed])
        @tasks = current_user.tasks
        @week = Week.find(params[:week_id])
        @days = @week.days
        @events = events("primary", @week.start, @week.end).items
        @incomplete_todos = @tasks.where("todo = ? AND completed = ?", true, false)
        @complete_todos = @tasks.where("todo = ? AND completed = ?", true, true)
        respond_to do |format|
            format.html { redirect_to user_week_path(user_id: current_user.id, id: params[:week_id]) }
            format.js
        end
   end
   
   def destroy
        @task = Task.destroy(params[:id])
        @tasks = current_user.tasks
        @week = Week.find(params[:week_id])
        @events = events("primary", @week.start, @week.end).items
        @days = @week.days
        @incomplete_todos = @tasks.where("todo = ? AND completed = ?", true, false)
        @complete_todos = @tasks.where("todo = ? AND completed = ?", true, true)
   end


    private
    
        def task_params
            params.permit(:user_id, :summary, :todo, :date)
        end
        
        def modify_date_param
            params[:date] = (params[:todo] === "1" ? "" : Date.strptime(params[:date], "%m/%d/%Y").to_s )
        end
   
    
end

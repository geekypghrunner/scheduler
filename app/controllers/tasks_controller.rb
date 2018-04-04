class TasksController < ApplicationController

  respond_to :html, :js

    
    def create
        @task = Task.create(:user_id => params[:user_id], :date => (params[:todo] === "1" ? "" : Date.strptime(params[:date], "%m/%d/%Y").to_s ), :summary => params[:summary], :todo => params[:todo], :completed => false)
        @week = Week.find(params[:id])
        @events = events("primary", @week.start, @week.end).items
        @tasks = current_user.tasks
        @days = @week.days
        @incomplete_todos = @tasks.where("todo = ? AND completed = ?", true, false)
        @complete_todos = @tasks.where("todo = ? AND completed = ?", true, true)
#        redirect_to user_week_path(user_id: current_user.id, id: params[:id])
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
   
    
end

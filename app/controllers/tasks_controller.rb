class TasksController < ApplicationController

  respond_to :html, :js
    
    before_action :authorized_user!
    before_action :modify_date_param, only: [:create]
    
    def create
        @task = Task.new(task_params)
        @task.completed = false
        @task.save
        @week = Week.find(params[:id])
        @tasks = current_user.tasks
    end
    
    def new
    end
   
   def update
        @task = Task.find(params[:id])
        @task.update(:completed => params[:task][:completed])
        @tasks = current_user.tasks
        @week = Week.find(params[:week_id])
        respond_to do |format|
            format.html { redirect_to user_week_path(user_id: current_user.id, id: params[:week_id]) }
            format.js
        end
   end
   
   def destroy
        @task = Task.destroy(params[:id])
        @tasks = current_user.tasks
        @week = Week.find(params[:week_id])
   end


    private
    
        def task_params
            params.permit(:user_id, :summary, :todo, :date, :task_type)
        end
        
        def modify_date_param
            params[:date] = (params[:todo] === "1" ? "" : Date.strptime(params[:date], "%m/%d/%Y").to_s )
        end
   
    
end

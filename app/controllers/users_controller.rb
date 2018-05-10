class UsersController < ApplicationController
    
    def index
        calendars
    end
    
    def settings
        @user = current_user
        @list_calendars = []
        calendars.items.each do |calendar| 
          @list_calendars.push([calendar.id, calendar.summary]) 
        end
    end
    
    def welcome
    end
    
    def update
        @user = current_user
        @user.update(user_params)
    end

    private
        def user_params
            params.require(:user).permit(:cal_list => [])
        end

end

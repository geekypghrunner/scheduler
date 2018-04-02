class UsersController < ApplicationController
    
    def index
        @users = User.all
        calendars
        events("primary", current_user.weeks.first.start, current_user.weeks.last.end)
    end
end

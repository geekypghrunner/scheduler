class UsersController < ApplicationController
    
    def index
        @users = User.all
        calendars
        events("primary")
    end
end

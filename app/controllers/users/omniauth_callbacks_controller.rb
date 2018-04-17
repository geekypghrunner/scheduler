class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      if @user.cal_list.nil?
        first_calendars = []
        calendars.items.each do |calendar| 
          first_calendars.push(calendar.id) 
        end
        @user.update(cal_list: first_calendars)
      end
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
    end
    redirect_to '/'
  end

end
require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  Calendar = Google::Apis::CalendarV3

  

  def calendars
    secrets = Google::APIClient::ClientSecrets.new(
      {
        "web" =>
          {
            "access_token" => current_user.token,
            "refresh_token" => current_user.refresh_token,
            "client_id" => ENV["google_client_id"],
            "client_secret" => ENV["google_client_secret"]
          }
      }
    )
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = secrets.to_authorization
    service.authorization.refresh!
    @calendar_list = service.list_calendar_lists
  end

  def events(id, start_date, end_date)
    secrets = Google::APIClient::ClientSecrets.new(
      {
        "web" =>
          {
            "access_token" => current_user.token,
            "refresh_token" => current_user.refresh_token,
            "client_id" => ENV["google_client_id"],
            "client_secret" => ENV["google_client_secret"]
          }
      }
    )
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = secrets.to_authorization
    service.authorization.refresh!

    @event_list = service.list_events(id, order_by: "starttime", single_events: true, time_min: start_date, time_max: end_date, fields: "items(summary,id,start(date_time, date))")
  end

  def authorized_user!
    if params[:user_id] != current_user.id.to_s
      redirect_to root_path
    end
  end

end

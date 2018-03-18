require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
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

    @calendar_list = service.list_calendar_lists

#    response = service.list_calendar_lists
#    render json: response
  end

  def events(id)
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

    @event_list = service.list_events(id, order_by: "starttime", single_events: true)

#    response = service.list_calendar_lists
#    render json: response
  end

end

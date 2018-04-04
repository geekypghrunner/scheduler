class User < ApplicationRecord
  
  after_create do 
    @week = Week.create(:user_id => User.last.id, :start => (DateTime.now-DateTime.now.strftime("%w").to_i).to_date.to_datetime.change(:offset => "-0400").to_s, :end => ((DateTime.now-DateTime.now.strftime("%w").to_i).to_date.to_datetime.change(:offset => "-0400")+6).change(hour: 23, min: 59, sec: 59))
    7.times do |i|
      Day.create(:user_id => User.last.id, :week_id => @week.id, :date => (@week.start.to_date + i).to_s)
    end
  end
  
  has_many :weeks
  has_many :tasks
  has_many :days
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, 
  devise :database_authenticatable,:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  
  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID   
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
    end
  end
         
end

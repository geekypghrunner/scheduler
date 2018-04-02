class Week < ApplicationRecord
    
    belongs_to :user
    
    def dated_events
        7.times do |i|
            @day[i] = events("primary", @week.start, @week.end).items.keep_if{ |event| event.start.date == (@week.start.to_date + i).to_s  } 
        end
    end
    
end

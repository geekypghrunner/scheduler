class Task < ApplicationRecord
  belongs_to :user
  
  validates :task_type, :presence => true
  validates :summary, :presence => true
  
end

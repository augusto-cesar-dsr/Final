class AdminStatistic < ApplicationRecord
  EVENTS ={
    total_users: "TOTAL_USERS",
    total_questions: "TOTAL_QUESTIONS"
  }
  
  # scopes
  scope :total_users, ->{
    find_by_event(EVENTS[:total_users]).value
  }
  scope :total_questions, ->{
    find_by_event(EVENTS[:total_questions]).value
  }
  # class methods
  def self.set_event(event)
    statistic = AdminStatistic.find_or_create_by(event: event)
    statistic.value += 1
    statistic.save
  end
end

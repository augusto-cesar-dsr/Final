class AdminStatistic < ApplicationRecord
  EVENTS ={
    total_users: "TOTAL_USERS",
    total_questions: "TOTAL_QUESTIONS"
  }
  def self.set_event(event)
    statistic = AdminStatistic.find_or_create_by(event: event)
    statistic.value += 1
    statistic.save
  end
end

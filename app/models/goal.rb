class Goal < ApplicationRecord
  validates :name, :user_id, presence: true
  validates :goal_status, inclusion: [false, true]
  before_validation :ensure_goal_status

  belongs_to :user

  def complete!
    self.goal_status = true
    self.save
  end

  def ensure_goal_status
    self.goal_status ||= false
  end

end

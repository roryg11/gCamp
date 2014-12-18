class Task < ActiveRecord::Base
  validates :description, presence: true
  validate :due_date_cannot_be_in_the_past, on: :create

  belongs_to :project

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "due date cannot be in the past")
    end
  end

end

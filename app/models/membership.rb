class Membership < ActiveRecord::Base
  validates :user_id, :role, presence: true

  belongs_to :project
  belongs_to :user
end

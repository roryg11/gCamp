class Membership < ActiveRecord::Base
  validates :role, presence: true
  validates :user_id, presence: true
  validate :project_user_id_does_not_exist?

  belongs_to :project
  belongs_to :user

  def project_user_id_does_not_exist?
    if Membership.where(project_id: project_id, user_id: user_id).length > 0 && !self.id
      errors.add(:base, "member already exists")
    end
  end

end

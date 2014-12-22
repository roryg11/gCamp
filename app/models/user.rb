class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_many :memberships
  has_many :projects, through: :memberships
  has_secure_password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end

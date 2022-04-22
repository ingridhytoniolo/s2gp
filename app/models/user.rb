class User < ApplicationRecord
  after_create :create_profile

  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, update_only: true

  serialize :roles, Array

  def admin?
    roles.include?('admin')
  end

  def researcher?
    return false unless profile

    profile.members.find_by(status: 'accepted', role: 'researcher').present?
  end
end

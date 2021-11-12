class User < ApplicationRecord
  after_create :create_profile

  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  serialize :roles, Array

  def admin?
    roles.include?('admin')
  end
end

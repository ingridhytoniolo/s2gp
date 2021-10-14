class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  serialize :roles, Array

  def admin?
    roles.include?('admin')
  end
end

class Profile < ApplicationRecord
  has_one_attached :avatar

  validates :user_id, presence: true, uniqueness: true
  validates :name, presence: true, on: :update
end

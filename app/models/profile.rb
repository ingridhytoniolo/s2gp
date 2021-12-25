class Profile < ApplicationRecord
  enum role: { researcher: 'researcher', student: 'student' }

  has_one_attached :avatar

  validate :validate_avatar, on: :update

  validates :name, presence: true, on: :update
  validates :user_id, presence: true, uniqueness: true

  private

  def validate_avatar
    validate_image(avatar)
  end
end

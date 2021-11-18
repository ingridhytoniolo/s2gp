class Profile < ApplicationRecord
  enum role: { researcher: 'researcher', student: 'student' }

  has_one_attached :avatar

  validate :validate_avatar, on: :update

  validates :name, presence: true, on: :update
  validates :user_id, presence: true, uniqueness: true

  private

  def validate_avatar
    return unless avatar.attached?
    
    unless avatar.byte_size <= 1.megabyte
      errors.add(:avatar, '{too_big}')
    end
  
    acceptable_types = ['image/jpeg', 'image/png']
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, '{must_be_a_jpeg_or_png}')
    end
  end
end

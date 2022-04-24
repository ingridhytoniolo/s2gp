class News < ApplicationRecord
  belongs_to :profile

  has_one_attached :cover

  validate :validate_cover, on: [:update]

  validates :description, presence: true
  validates :profile_id, presence: true
  validates :title, presence: true

  scope :active, -> {
    where("(start_at IS NULL OR start_at <= '#{Time.now}') AND (end_at IS NULL OR end_at >= '#{Time.now}')")
  }

  private

  def validate_cover
    validate_image(cover)
  end
end

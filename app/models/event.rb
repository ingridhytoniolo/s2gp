class Event < ApplicationRecord
  belongs_to :profile

  has_one_attached :cover

  validate :validate_cover, on: [:update]

  validates :description, presence: true
  validates :profile_id, presence: true
  validates :title, presence: true

  scope :active, -> {
    where("date >= '#{Time.now}'")
  }

  private

  def validate_cover
    validate_image(cover)
  end
end

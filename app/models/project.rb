class Project < ApplicationRecord
  enum status: { created: 'created', done: 'done', paused: 'paused' }, _default: 'created'

  before_validation :generate_slug

  has_one_attached :avatar

  validate :validate_avatar, on: :update

  validates :slug, presence: true, uniqueness: true
  validates :start_at, presence: true
  validates :title, presence: true

  private

  def generate_slug
    self.slug = title.parameterize
  end

  def validate_avatar
    validate_image(avatar)
  end
end

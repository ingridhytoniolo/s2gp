class Profile < ApplicationRecord
  enum role: { researcher: 'researcher', student: 'student' }

  has_one_attached :avatar

  has_many :members
  has_many :projects, through: :members

  validate :validate_avatar, on: :update

  validates :name, presence: true, on: :update
  validates :user_id, presence: true, uniqueness: true

  scope :actives, -> {
    joins(:members).where(members: { status: 'accepted' })
  }

  scope :by_roles, -> {
    order(Arel.sql("(CASE WHEN profiles.role = 'researcher' THEN 0 ELSE 1 END)"), :name)
  }

  private

  def validate_avatar
    validate_image(avatar)
  end
end

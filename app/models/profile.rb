class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  has_many :meetings
  has_many :members
  has_many :news
  has_many :projects, through: :members

  validate :validate_avatar, on: :update

  validates :name, presence: true, on: :update
  validates :user_id, presence: true, uniqueness: true

  scope :active, -> {
    joins(:members).where(members: { status: 'accepted' }).group(:id).order(:name)
  }

  scope :not_refused, -> {
    joins(:members).where.not(members: { status: 'refused' }).group(:id).order(:name)
  }

  def main_role
    members.by_roles.first.try(:role)
  end

  private

  def validate_avatar
    validate_image(avatar)
  end
end

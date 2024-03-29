class Project < ApplicationRecord
  enum status: { created: 'created', done: 'done', paused: 'paused' }, _default: 'created'

  before_validation :generate_slug

  has_and_belongs_to_many :resources, -> { distinct }

  has_one_attached :avatar

  has_many :activities
  has_many :meetings
  has_many :members

  validate :validate_avatar, on: :update

  validates :slug, presence: true, uniqueness: true
  validates :start_at, presence: true
  validates :title, presence: true

  scope :active, -> {
    where(status: 'created').order(:title)
  }

  scope :by_status, -> {
    order(Arel.sql("(CASE WHEN status = 'created' THEN 0 WHEN status = 'paused' THEN 1 ELSE 2 END)"), :title)
  }

  def can_join?(profile_id)
    Profile.find(profile_id).name.present? && members.find_by(profile_id: profile_id).nil?
  end

  def member?(profile_id)
    current_member = members.find_by(profile_id: profile_id)

    current_member && current_member.status == 'accepted'
  end

  def member_status(profile_id)
    members.find_by(profile_id: profile_id)&.status
  end

  def researcher?(profile_id)
    member = members.find_by(profile_id: profile_id)

    member.status == 'accepted' && member.role == 'researcher'
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end

  def validate_avatar
    validate_image(avatar)
  end
end

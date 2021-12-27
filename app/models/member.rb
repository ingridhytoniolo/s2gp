class Member < ApplicationRecord
  enum status: { pending: 'pending', accepted: 'accepted', refused: 'refused' }, _default: 'pending'
  enum role: { researcher: 'researcher', student: 'student' }

  belongs_to :profile
  belongs_to :project

  validates :profile_id, presence: true, uniqueness: { scope: [ :project_id ] }
  validates :project_id, presence: true

  scope :by_roles, -> {
    joins(:profile).order(Arel.sql("(CASE WHEN members.role = 'researcher' THEN 0 ELSE 1 END)"), 'profiles.name')
  }
end

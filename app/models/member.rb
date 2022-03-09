class Member < ApplicationRecord
  enum status: { pending: 'pending', accepted: 'accepted', refused: 'refused' }, _default: 'pending'
  enum role: { researcher: 'researcher', student: 'student' }

  belongs_to :profile
  belongs_to :project

  validates :profile_id, presence: true, uniqueness: { scope: [ :project_id ] }
  validates :project_id, presence: true

  scope :actives, -> {
    where(status: 'accepted')
  }

  scope :by_roles, -> {
    order(Arel.sql("(CASE WHEN role = 'researcher' THEN 0 WHEN role = 'student' THEN 1 ELSE 2 END)"))
  }
end

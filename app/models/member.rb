class Member < ApplicationRecord
  enum status: { pending: 'pending', accepted: 'accepted', refused: 'refused' }, _default: 'pending'
  enum role: { researcher: 'researcher', student: 'student' }
  
  belongs_to :profile
  belongs_to :project

  accepts_nested_attributes_for :profile
  
  validates :profile_id, presence: true, uniqueness: { scope: [ :project_id ] }
  validates :project_id, presence: true

  scope :active, -> {
    where(status: 'accepted')
  }

  scope :by_name, -> {
    includes(:profile).order('profiles.name')
  }

  scope :by_roles, -> {
    order(Arel.sql("(CASE WHEN role = 'researcher' THEN 0 WHEN role = 'student' THEN 1 ELSE 2 END)")).by_name
  }
end

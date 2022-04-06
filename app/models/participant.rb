class Participant < ApplicationRecord
  belongs_to :participating, polymorphic: true

  belongs_to :profile

  validates :profile_id, presence: true, uniqueness: { scope: [:participating_type, :participating_id] }

  scope :by_name, -> {
    includes(:profile).order('profiles.name')
  }
end

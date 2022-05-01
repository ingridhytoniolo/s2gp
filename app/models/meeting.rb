class Meeting < ApplicationRecord
  belongs_to :profile
  belongs_to :project

  validates :date, presence: true
  validates :profile_id, presence: true
  validates :title, presence: true

  scope :active, -> {
    where("date >= '#{Time.now}'")
  }
end

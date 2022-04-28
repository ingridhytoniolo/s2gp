class Meeting < ApplicationRecord
  belongs_to :profile
  has_one :project

  validates :date, presence: true
  validates :profile_id, presence: true
  validates :title, presence: true

  scope :active, -> {
    where("date >= '#{Time.now}'")
  }
end

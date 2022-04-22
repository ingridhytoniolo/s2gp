class Resource < ApplicationRecord
  enum kind: { financial: 'financial', material: 'material' }

  has_and_belongs_to_many :projects, -> { distinct }

  validates :kind, presence: true
  validates :name, presence: true
end

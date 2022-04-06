class Activity < ApplicationRecord
  enum priority: { high: 'high', medium: 'medium', low: 'low' }, _default: 'medium'
  enum status: { created: 'created', started: 'started', done: 'done' }, _default: 'created'
  
  PRIORITY_ORDER = ['high', 'medium', 'low']
  STATUS_ORDER = ['started', 'created', 'done']

  belongs_to :project

  has_many :participants, as: :participating, dependent: :destroy

  validates :description, presence: true

  scope :order_by_priority, -> { order(Arel.sql(PRIORITY_ORDER.map{ |priority| "priority='#{priority}' DESC" }.join(', '))) }
  scope :order_by_status, -> { order(Arel.sql(STATUS_ORDER.map{ |status| "status='#{status}' DESC" }.join(', '))) }
end

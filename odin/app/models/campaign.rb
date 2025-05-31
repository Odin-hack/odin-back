class Campaign < ApplicationRecord
  has_many :ad_groups, dependent: :destroy

  accepts_nested_attributes_for :ad_groups, allow_destroy: true

  enum :status, [ :paused, :enabled, :removed ]
  enum :advertising_channel_type, [ :video, :search, :shopping, :local_services, :travel ]

  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :budget_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :advertising_channel_type, presence: true
  validates :status, presence: true
end

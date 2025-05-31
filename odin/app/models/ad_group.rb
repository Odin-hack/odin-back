class AdGroup < ApplicationRecord
  belongs_to :campaign

  enum :status, [ :enabled, :paused, :removed ]
  enum :ad_group_type, [ :search_standard, :display_standard ]

  validates :name, presence: true, uniqueness: true
  validates :status, presence: true
  validates :cpc_bid_micros, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :ad_group_type, presence: true
end

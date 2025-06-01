class AdGroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :ad_group_type, :cpc_bid_micros, :campaign_id

  has_many :ads, serializer: AdSerializer
end

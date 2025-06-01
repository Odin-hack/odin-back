class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :budget_amount, :status, :advertising_channel_type

  has_many :ad_groups, serializer: AdGroupSerializer
end

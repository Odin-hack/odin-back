class Api::AnalyticsController < ApplicationController
  def overview
    render json: {
      total_campaigns: Campaign.count,
      total_ad_groups: AdGroup.count,
      total_ads: Ad.count,
      campaigns_by_status: Campaign.group(:status).count,
      total_budget: Campaign.sum(:budget_amount),
      average_budget: Campaign.average(:budget_amount).to_i,
      average_cpc_bid_micros: AdGroup.average(:cpc_bid_micros).to_i,
      ads_by_type: Ad.group(:ad_type).count
    }
  end

  def ending_soon
    campaigns = Campaign.where(end_date: Date.today..7.days.from_now)
    render json: campaigns, each_serializer: CampaignSerializer
  end

  def empty_campaigns
		campaigns = Campaign.includes(ad_groups: :ads).select do |campaign|
			campaign.ad_groups.none? || campaign.ad_groups.all? { |group| group.ads.none? }
		end
		render json: campaigns, each_serializer: CampaignSerializer
	end
end

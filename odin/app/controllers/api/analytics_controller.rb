class Api::AnalyticsController < ApplicationController
  def overview
    user_campaigns = current_user.campaigns
    campaign_ids = user_campaigns.pluck(:id)

    render json: {
      total_campaigns: user_campaigns.count,
      total_ad_groups: AdGroup.where(campaign_id: campaign_ids).count,
      total_ads: Ad.joins(:ad_group).where(ad_groups: { campaign_id: campaign_ids }).count,
      campaigns_by_status: user_campaigns.group(:status).count,
      total_budget: user_campaigns.sum(:budget_amount),
      average_budget: user_campaigns.average(:budget_amount).to_i,
      average_cpc_bid_micros: AdGroup.where(campaign_id: campaign_ids).average(:cpc_bid_micros).to_i,
      ads_by_type: Ad.joins(:ad_group).where(ad_groups: { campaign_id: campaign_ids }).group(:ad_type).count
    }
  end

  def ending_soon
    campaigns = current_user.campaigns.where(end_date: Date.today..7.days.from_now)
    render json: campaigns, each_serializer: CampaignSerializer
  end

  def empty_campaigns
    campaigns = current_user.campaigns.includes(ad_groups: :ads).select do |campaign|
      campaign.ad_groups.none? || campaign.ad_groups.all? { |group| group.ads.none? }
    end
    render json: campaigns, each_serializer: CampaignSerializer
  end
end

class Api::CampaignsController < ApplicationController
  before_action :set_campaign, only: [ :show, :update ]

  def index
    campaigns = Campaign.includes(ad_groups: :ads).all
    render json: campaigns, include: [ "ad_groups", "ad_groups.ads" ]
  end

  def show
    render json: @campaign, include: [ "ad_groups", "ad_groups.ads" ]
  end

  def create
    result = Campaign::CreateService.call(campaign_params.merge(user: current_user))

    if result.success?
      render json: result.payload, status: :created
    else
      render json: { errors: result.error }, status: :unprocessable_entity
    end
  end

  def update
    if @campaign.update(campaign_params)
      render json: @campaign
    else
      render json: { errors: @campaign.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Campaign not found" }, status: :not_found
  end

  def campaign_params
    params.require(:campaign).permit(
      :name,
      :start_date,
      :end_date,
      :budget_amount,
      :status,
      :advertising_channel_type,
      ad_groups_attributes: [
        :name,
        :status,
        :cpc_bid_micros,
        :ad_group_type,
        ads_attributes: [
          :name,
          :status,
          :ad_type,
          :final_url,
          :headline1,
          :headline2,
          :description,
          :image_data,
          :video,
          countries: []
        ]
      ]
    )
  end
end

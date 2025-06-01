class Api::AdGroupsController < ApplicationController
  before_action :set_campaign
  before_action :set_ad_group, only: [ :show, :update ]

  def index
    ad_groups = @campaign.ad_groups
    render json: ad_groups
  end

  def show
    render json: @ad_group
  end

  def create
    result = AdGroup::CreateService.call(ad_group_params.merge(campaign_id: @campaign.id))

    if result.success?
      render json: result.payload, status: :created
    else
      render json: { errors: result.error }, status: :unprocessable_entity
    end
  end

  def update
    if @ad_group.update(ad_group_params)
      render json: @ad_group
    else
      render json: { errors: @ad_group.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Campaign not found" }, status: :not_found
  end

  def set_ad_group
    @ad_group = @campaign.ad_groups.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ad group not found" }, status: :not_found
  end

  def ad_group_params
    params.require(:ad_group).permit(
      :name,
      :status,
      :cpc_bid_micros,
      :ad_group_type,
      ads_attributes: [
        :id, :name, :status, :ad_type, :final_url,
        :headline1, :headline2, :description,
        :image_data, :video, :_destroy
      ])
  end
end

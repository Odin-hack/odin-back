class Api::AdsController < ApplicationController
  before_action :set_campaign, :set_ad_group
  before_action :set_ad, only: [ :show, :update ]

  def index
    render json: @ad_group.ads
  end

  def show
    render json: @ad
  end

  def create
    result = Ad::CreateService.call(ad_params.merge(ad_group_id: @ad_group.id))

    if result.success?
      render json: result.payload, status: :created
    else
      render json: { errors: result.error }, status: :unprocessable_entity
    end
  end

  def update
    if @ad.update(ad_params)
      render json: @ad
    else
      render json: { errors: @ad.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_campaign
    @campaign = current_user.campaigns.find(params[:campaign_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Campaign not found or access denied" }, status: :not_found
  end

  def set_ad_group
    @ad_group = AdGroup.find(params[:ad_group_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ad group not found" }, status: :not_found
  end

  def set_ad
    @ad = @ad_group.ads.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ad not found" }, status: :not_found
  end

  def ad_params
    params.require(:ad).permit(
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
    )
  end
end

class Campaign::CreateService < ApplicationService
  def call(params)
    campaign = Campaign.new(params)

    if campaign.save
      success(campaign)
    else
      failure(campaign.errors.full_messages.to_sentence)
    end
  end
end

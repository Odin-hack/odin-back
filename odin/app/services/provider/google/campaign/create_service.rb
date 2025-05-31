class Provider::Google::Campaign::CreateService < ApplicationService
  def call(params)
    @client = Google::Ads::GoogleAds::GoogleAdsClient.new
    @name = params[:name]
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    @budget_resource = CreateBugdetService.call(@client, params[:name], params[:budget_amount])

    create_campaign_resource
  end

  private

  def create_campaign_resource
    campaign_op = client.operation.create_resource.campaign(init_campaign)
    campaign_response = client.service.campaign.mutate_campaigns(
      customer_id: "3519169925",
      operations: [ campaign_op ]
    )
    campaign_resource = campaign_response.results.first.resource_name
  end

  def init_campaign(params)
    @client.resource.campaign do |c|
      c.name = @name
      c.advertising_channel_type = :SEARCH
      c.status = :ENABLED
      c.manual_cpc = client.resource.manual_cpc
      c.campaign_budget = @budget_resource
      c.start_date = @start_date
      c.end_date   = @end_date
    end
  end
end

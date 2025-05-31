require "google/ads/google_ads"

class Provider::Google::Campaign::CreateBugdetService < ApplicationService
  def call(client, campaign_name, amount)
    @client = client
    @campaign_name = campaign_name
    @amount = amount

    campaign_budget = init_campaign_budget

    create_budget_resource(campaign_budget)
  end

  private

  def init_campaign_budget
    @client.resource.campaign_budget do |cb|
      cb.name = "#{@campaign_name}_budget_amount"
      cb.amount_micros = @amount
      cb.delivery_method = :STANDARD
    end
  end

  def create_budget_resource(budget)
    budget_op = client.operation.create_resource.campaign_budget(budget)
    budget_response = client.service.campaign_budget.mutate_campaign_budgets(
      customer_id: "3519169925",
      operations: [ budget_op ]
    )
    budget_resource = budget_response.results.first.resource_name
  end
end

set :output, "log/cron.log"
set :environment, "development"

every 5.days do
  runner "CampaignEvolutionService.call"
end

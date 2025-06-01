set :output, "log/cron.log"
set :environment, "development"

every 5.minutes do
  runner "CampaignEvolutionService.call"
end

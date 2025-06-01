set :output, "log/cron.log"
set :environment, "production" # or "development" for testing

every 5.minutes do
  runner "CampaignEvolutionService.call"
end

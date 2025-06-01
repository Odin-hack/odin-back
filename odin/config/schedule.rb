set :output, "log/cron.log"
set :environment, "production" # or "development" for testing

every 1.day, at: '3:00 am' do
  runner "CampaignEvolutionService.call"
end

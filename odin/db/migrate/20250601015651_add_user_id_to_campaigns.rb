class AddUserIdToCampaigns < ActiveRecord::Migration[7.2]
  def change
    add_reference :campaigns, :user, foreign_key: true
  end
end

class AddLastEvolvedAtToAds < ActiveRecord::Migration[7.2]
  def change
    add_column :ads, :last_evolved_at, :datetime
  end
end

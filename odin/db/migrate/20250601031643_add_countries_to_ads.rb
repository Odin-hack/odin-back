class AddCountriesToAds < ActiveRecord::Migration[7.2]
  def change
    add_column :ads, :countries, :string
  end
end

class CreateAdGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :ad_groups do |t|
      t.string :name
      t.references :campaign, null: false, foreign_key: true
      t.integer :status
      t.bigint :cpc_bid_micros
      t.integer :ad_group_type

      t.timestamps
    end
  end
end

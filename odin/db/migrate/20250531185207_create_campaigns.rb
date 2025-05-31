class CreateCampaigns < ActiveRecord::Migration[7.2]
  def change
    create_table :campaigns do |t|
      t.string  :name, null: false
      t.date    :start_date
      t.date    :end_date
      t.bigint  :budget_amount, null: false
      t.integer :advertising_channel_type, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end

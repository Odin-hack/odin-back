class CreateAds < ActiveRecord::Migration[7.2]
  def change
    create_table :ads do |t|
      t.references :ad_group, null: false, foreign_key: true
      t.string :name
      t.integer :status
      t.integer :ad_type
      t.string :final_url

      t.string :headline1
      t.string :headline2
      t.text :description

      t.timestamps
    end
  end
end

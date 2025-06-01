class CreateAdHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :ad_histories do |t|
      t.references :ad, null: false, foreign_key: true
      t.string :field_changed
      t.string :old_value
      t.string :new_value

      t.timestamps
    end
  end
end

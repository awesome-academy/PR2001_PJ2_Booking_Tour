class AddIndexToRates < ActiveRecord::Migration[6.0]
  def change
    add_index :rates, [:user_id, :tour_id], unique: true
  end
end

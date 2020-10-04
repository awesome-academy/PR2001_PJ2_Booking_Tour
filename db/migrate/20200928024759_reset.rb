class Reset < ActiveRecord::Migration[6.0]
  def change
    rename_column :tours, :description, :itinerary
    rename_column :tours, :tourist_attraction, :price_info
    rename_column :tours, :restaurant, :food_and_drink
  end
end

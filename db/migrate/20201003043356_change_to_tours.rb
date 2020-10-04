class ChangeToTours < ActiveRecord::Migration[6.0]
  def change
    remove_column :tours, :food_and_drink
    rename_column :hotel_tours, :option, :extra_fee
  end
end

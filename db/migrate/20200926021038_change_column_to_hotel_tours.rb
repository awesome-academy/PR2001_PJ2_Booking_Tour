class ChangeColumnToHotelTours < ActiveRecord::Migration[6.0]
  def change
    change_column :hotel_tours, :option, :integer
  end
end

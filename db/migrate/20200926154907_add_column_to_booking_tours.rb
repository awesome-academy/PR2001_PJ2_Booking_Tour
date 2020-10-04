class AddColumnToBookingTours < ActiveRecord::Migration[6.0]
  def change
    add_column :booking_tours, :option, :integer
  end
end

class RenameColumnToCoupons < ActiveRecord::Migration[6.0]
  def change
    rename_column :coupons, :coupon_start_date, :date_start
    rename_column :coupons, :coup_end_date, :date_end    
  end
end

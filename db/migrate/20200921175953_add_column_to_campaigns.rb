class AddColumnToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :date_start, :date
    add_column :campaigns, :date_end, :date
  end
end

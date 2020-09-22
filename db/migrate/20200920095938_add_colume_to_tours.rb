class AddColumeToTours < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :tourist_attraction, :text
    add_column :tours, :transport, :string
    add_column :tours, :restaurant, :text
  end
end

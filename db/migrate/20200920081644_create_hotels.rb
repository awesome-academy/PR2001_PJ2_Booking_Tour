class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :location
      t.text :overview
      t.string :link
      t.timestamps
    end
  end
end

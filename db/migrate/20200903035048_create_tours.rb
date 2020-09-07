class CreateTours < ActiveRecord::Migration[6.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.references :categories, null: false, foreign_key: true
      t.integer :description
      t.integer :price
      t.integer :coupon
      t.integer :seats_total
      t.timestamps
    end
    add_index :tours, [:category_id, :created_at]
  end
end

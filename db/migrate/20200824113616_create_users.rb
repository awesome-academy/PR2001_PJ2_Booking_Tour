class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :coin, default: 0
      t.boolean :admin, default: true
    end
  end
end

class AddColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :overview, :text
  end
end

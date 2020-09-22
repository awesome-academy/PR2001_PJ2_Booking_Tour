class AddColumnNumbersOfUse < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :numbers_of_use, :integer
    add_column :campaigns, :content, :string
  end
end

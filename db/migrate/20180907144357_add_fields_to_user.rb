class AddFieldsToUser < ActiveRecord::Migration[5.2]

  def change
    add_column :users, :reputation, :decimal, precision: 3, scale: 1
  end

end

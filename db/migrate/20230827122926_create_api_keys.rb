class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :key, unique: true
      t.boolean :revoked, default: false

      t.timestamps
    end
  end
end

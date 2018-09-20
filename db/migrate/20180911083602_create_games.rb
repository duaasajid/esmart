class CreateGames < ActiveRecord::Migration[5.2]
  def change

    create_table :games do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :api_url
      t.boolean :enabled, null: false, default: false

      t.timestamps null: false
    end

  end
end

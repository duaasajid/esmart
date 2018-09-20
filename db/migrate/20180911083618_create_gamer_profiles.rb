class CreateGamerProfiles < ActiveRecord::Migration[5.2]
  def change

    create_table :gamer_profiles do |t|
      t.references :game
      t.references :user
      t.string :handle, null: false

      t.timestamps null: false
    end

  end
end

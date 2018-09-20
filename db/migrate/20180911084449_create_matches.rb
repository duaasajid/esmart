class CreateMatches < ActiveRecord::Migration[5.2]
  def change

    create_table :matches do |t|
      t.references :game
      t.references :player1
      t.references :player2
      t.references :winner
      t.decimal :score1, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :score2, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps null: false
    end

  end
end

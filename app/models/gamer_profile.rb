class GamerProfile < ApplicationRecord

  # Associations
  belongs_to :game
  belongs_to :user

  # Validations
  validates :game, presence: true
  validates :user, presence: true
  validates :handle, presence: true
  validates :user_id, uniqueness: { scope: :game_id }

end

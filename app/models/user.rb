class User < ApplicationRecord
  include SoftDeletable
  include RemovableFile

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_removable_file :avatar

  # Associations
  has_many :gamer_profiles
  has_many :games, -> { order(:title) }, through: :gamer_profiles
  has_many :matches_played, -> (object) { unscope(:where).where('player1_id = :player_id OR player2_id = :player_id', player_id: object.id) }, class_name: 'Match'
  has_many :matches_won, class_name: 'Match', foreign_key: :winner_id

  has_one_attached :avatar

  # Validations
  validates :reputation, numericality: true, allow_nil: true

  # Callbacks
  after_commit :fetch_reputation, on: :create

  #scopes
  scope :opponents, -> (user_id, game_id) { where.not(id: user_id).joins(:gamer_profiles).where(gamer_profiles: { game_id: game_id }) }

  def cheater
    reputation && reputation < 7.0
  end

  private

  def fetch_reputation
    self.reputation = ReputationFetcher.fetch(email)
    save if reputation_changed?
  end

end

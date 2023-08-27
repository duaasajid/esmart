class ApiKey < ApplicationRecord
  before_validation :generate_key, on: :create
  validates :key, presence: true, uniqueness: true

  def revoke
    update(revoked: true)
  end

  private

  def generate_key
    self.key = SecureRandom.hex(16)
  end
end

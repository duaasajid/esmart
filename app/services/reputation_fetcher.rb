class ReputationFetcher

  def self.fetch(email)
    new(email).fetch
  end

  def initialize(email)
    @email = email
  end

  attr_reader :email

  def fetch
    begin
      client.get_reputation(email)
    rescue AntiCheat::RandomError => e
      Rollbar.error(e)
      nil
    end
  end

  def client
    AntiCheat::Client.new
  end

end

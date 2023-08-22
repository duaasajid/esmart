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
    rescue => e
      Rollbar.error(e, user_email: email, user_id: User.find_by_email(email).id)
    end
  end

  def client
    AntiCheat::Client.new
  end

end

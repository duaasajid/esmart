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
      Rollbar.error(e, user_email: current_user.email, user_id: current_user.id,
      user_agent: request.user_agent, remote_ip: request.remote_ip)
    end
  end

  def client
    AntiCheat::Client.new
  end

end

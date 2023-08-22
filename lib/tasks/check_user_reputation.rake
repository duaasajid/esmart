
# rails check_user_reputation:fetch

namespace :check_user_reputation do
  task fetch: :environment do
    User.all.each do |user|
      user_reputation = ReputationFetcher.fetch(user.email)
      if user.reputation != user_reputation
        user.update(reputation: user_reputation)
        puts "Updated reputation for User #{user.email} is #{user.reputation}"
      end
    end
  end
end

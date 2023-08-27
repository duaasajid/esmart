# rails gdpr:purge
namespace :gdpr do

  desc 'Purges record marked for GDPR cleanup'
  task purge: :environment do
    User.deleted.destroy_all
    User.deleted.includes(:games, :gamer_profiles, :matches, :avatar).destroy_all
  end
end
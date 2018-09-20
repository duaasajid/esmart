namespace :gdpr do

  desc 'Purges record marked for GDPR cleanup'
  task purge: :environment do
    User.deleted.destroy_all
  end
end
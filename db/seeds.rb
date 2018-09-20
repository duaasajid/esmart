# Populate db from fixtures

Rake::Task['db:fixtures:load'].invoke

# Attach avatars to users

ken = User.find_by(email: 'ken@capcom.com')
ken.avatar.attach(io: File.open(Rails.root.join('test/fixtures/files', 'avatars/ken.png')), filename: 'ken.png') if ken && !ken.avatar.attached?

ryu = User.find_by(email: 'ryu@capcom.com')
ryu.avatar.attach(io: File.open(Rails.root.join('test/fixtures/files', 'avatars/ryu.png')), filename: 'ryu.png') if ryu && !ryu.avatar.attached?

blanka = User.find_by(email: 'blanka@capcom.com')
blanka.avatar.attach(io: File.open(Rails.root.join('test/fixtures/files','avatars/blanka.png')), filename: 'blanka.png') if blanka && !blanka.avatar.attached?

# Attach logos to games

wow = Game.find_by(slug: 'wow')
wow.logo.attach(io: File.open(Rails.root.join('test/fixtures/files', 'logos/wow.png')), filename: 'wow.png') if wow && !wow.logo.attached?

lol = Game.find_by(slug: 'lol')
lol.logo.attach(io: File.open(Rails.root.join('test/fixtures/files', 'logos/lol.png')), filename: 'lol.png') if lol && !lol.logo.attached?

pubg = Game.find_by(slug: 'pubg')
pubg.logo.attach(io: File.open(Rails.root.join('test/fixtures/files', 'logos/pubg.png')), filename: 'pubg.png') if pubg && !pubg.logo.attached?

lineage = Game.find_by(slug: 'lineage')
lineage.logo.attach(io: File.open(Rails.root.join('test/fixtures/files', 'logos/lineage.png')), filename: 'lineage.png') if lineage && !lineage.logo.attached?

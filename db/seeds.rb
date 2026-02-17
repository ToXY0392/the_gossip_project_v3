require "faker"
Faker::Config.locale = :fr

puts "\n🧹 Cleaning database..."

# Respecte l'ordre des dépendances
Like.destroy_all
Comment.destroy_all
GossipTag.destroy_all
Tag.destroy_all
PrivateMessageRecipient.destroy_all
PrivateMessage.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

puts "✅ Database cleaned.\n\n"

puts "🏙️ Creating cities..."
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
puts "✅ #{City.count} cities created.\n\n"

puts "👤 Creating users..."
10.times do
  first = Faker::Name.first_name
  last  = Faker::Name.last_name

  User.create!(
    first_name: first,
    last_name: last,
    description: Faker::Quote.famous_last_words,
    email: Faker::Internet.unique.email(name: "#{first}.#{last}"),
    age: rand(18..60),
    city: City.all.sample
  )
end
puts "✅ #{User.count} users created.\n\n"

# Petit helper pour des potins "bureau"
OFFICE_PLACES = [
  "près de la machine à café",
  "pendant la réunion du lundi",
  "dans l’open-space (sans honte)",
  "sur Slack à 23h47",
  "en call, micro ouvert",
  "devant le stagiaire traumatisé"
].freeze

OFFICE_DRAMA = [
  "a été vu en train de refactoriser le vendredi soir",
  "a envoyé un message passif-agressif avec un smiley",
  "a dit 'c’est quick' et a détruit le sprint",
  "a prétendu que 'ça marche chez moi'",
  "a relancé un thread 'URGENT' pour rien",
  "a renommé un fichier en FINAL_V7_OK_PROMIS"
].freeze

puts "🗣️ Creating gossips..."
20.times do
  author = User.all.sample

  Gossip.create!(
    title: "Breaking: #{Faker::Company.catch_phrase}",
    content: "#{author.first_name} #{OFFICE_DRAMA.sample} #{OFFICE_PLACES.sample}.",
    user: author
  )
end
puts "✅ #{Gossip.count} gossips created.\n\n"

puts "🏷️ Creating tags..."
10.times do
  Tag.create!(title: Faker::Hacker.noun)
end
puts "✅ #{Tag.count} tags created.\n\n"

puts "🔗 Linking tags to gossips..."
Gossip.find_each do |gossip|
  Tag.all.sample(rand(1..3)).each do |tag|
    GossipTag.create!(gossip: gossip, tag: tag)
  end
end
puts "✅ #{GossipTag.count} gossip_tags created.\n\n"

puts "📩 Creating private messages..."
8.times do
  sender = User.all.sample
  pm = PrivateMessage.create!(
    content: "Chut. #{Faker::Quote.matz} 🤫",
    sender: sender
  )

  User.where.not(id: sender.id).sample(rand(1..3)).each do |recipient|
    PrivateMessageRecipient.create!(
      private_message: pm,
      recipient: recipient
    )
  end
end
puts "✅ #{PrivateMessage.count} private_messages created."
puts "✅ #{PrivateMessageRecipient.count} private_message_recipients created.\n\n"

puts "💬 Creating comments..."
20.times do
  Comment.create!(
    content: "#{Faker::Quote.famous_last_words}… (source: tkt)",
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end
puts "✅ #{Comment.count} comments created.\n\n"

puts "❤️ Creating likes..."
20.times do
  Like.create!(
    user: User.all.sample,
    likeable: Gossip.all.sample
  )
end
puts "✅ #{Like.count} likes created.\n\n"

puts "📊 Seed summary:"
puts "Cities: #{City.count}"
puts "Users: #{User.count}"
puts "Gossips: #{Gossip.count}"
puts "Tags: #{Tag.count}"
puts "GossipTags: #{GossipTag.count}"
puts "PrivateMessages: #{PrivateMessage.count}"
puts "PM Recipients: #{PrivateMessageRecipient.count}"
puts "Comments: #{Comment.count}"
puts "Likes: #{Like.count}"
puts "\n✅ Seeding done!\n"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(username: 'eve')
user2 = User.create(username: 'boo')
user3 = User.create(username: 'candy')
user4 = User.create(username: 'wen')

artwork1 = Artwork.create(title: "fancy artwork", image_url: "abcd_1", artist_id: user1.id)
artwork2 = Artwork.create(title: "sad artwork", image_url: "abcd_2", artist_id: user2.id)
artwork3 = Artwork.create(title: "bad artwork", image_url: "abcd_3", artist_id: user3.id)
artwork4 = Artwork.create(title: "cool artwork", image_url: "abcd_4", artist_id: user3.id)

artworkShare1 = ArtworkShare.create(artwork_id: artwork1.id, viewer_id: user4.id)
artworkShare2 = ArtworkShare.create(artwork_id: artwork3.id, viewer_id: user4.id)
artworkShare3 = ArtworkShare.create(artwork_id: artwork3.id, viewer_id: user2.id)
artworkShare4 = ArtworkShare.create(artwork_id: artwork2.id, viewer_id: user3.id)

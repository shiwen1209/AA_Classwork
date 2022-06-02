# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email: 'wendy@gmail.com', password:'123456')
user2 = User.create(email: 'Da@gmail.com', password:'123456')
user3 = User.create(email: 'Oreo@gmail.com', password:'123456')

band1 = Band.create(name: "Blackpink")
band2 = Band.create(name: "One direction")
band3 = Band.create(name: "BTS")

album1 = Album.create(title: "Kill this love", year: 2019, band_id: band1.id, album_type: "studio")
album2 = Album.create(title: "Blackpink in your area", year: 2018, band_id: band1.id, album_type: "live")
album3 = Album.create(title: "BTS", year: 2018, band_id: band3.id, album_type: "studio")
album4 = Album.create(title: "Up all night", year: 2011, band_id: band2.id, album_type: "studio")

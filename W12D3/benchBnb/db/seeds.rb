# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Bench.delete_all
User.delete_all


bench1 = Bench.create!(
    "description": "Bernal Height", 
    "lat": 37.74331262754258,
    "lng": -122.41288076270723
    )

bench2 = Bench.create!(
    "description": "Painted ladies", 
    "lat": 37.783753023271274,
    "lng": -122.43485341807857
    )

bench3 = Bench.create!(
    "description": "Twin peaks", 
    "lat": 37.756343,
    "lng": -122.453393
    )

bench4 = Bench.create!(
    "description": "Coit tower", 
    "lat": 37.80952562329169,
    "lng": -122.40807424434475
    )



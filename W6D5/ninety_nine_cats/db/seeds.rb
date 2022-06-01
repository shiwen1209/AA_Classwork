# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

kitty1 = Cat.create(name: "Ivy", birth_date: '2005/01/01', color: 'black', sex: "F", description: 'a good cat')
kitty2 = Cat.create(name: "Oreo", birth_date: '2019/02/12', color: 'multi_colored', sex: "M", description: 'a tuxedo cat')
kitty3 = Cat.create(name: "Garfield", birth_date: '1998/01/01', color: 'orange', sex: "M", description: 'hates mondays')

kitty4 = Cat.create(name: "Ivy2", birth_date: '2005/01/01', color: 'black', sex: "F", description: 'a good cat')
kitty5= Cat.create(name: "Oreo2", birth_date: '2019/02/12', color: 'green', sex: "M", description: 'a tuxedo cat')
kitty6 = Cat.create(name: "Garfield2", birth_date: '1998/01/01', color: 'orange', sex: "M", description: 'hates mondays')

request1 = CatRentalRequest.create(cat_id: kitty1.id, start_date: '2022/01/05', end_date: '2022/01/10', status: "APPROVED")
request2 = CatRentalRequest.create(cat_id: kitty1.id, start_date: '2022/01/08', end_date: '2022/01/10')
request3 = CatRentalRequest.create(cat_id: kitty1.id, start_date: '2022/01/10', end_date: '2022/01/12')

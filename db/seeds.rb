# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require 'faker'

puts 'Clean DB'
Cocktail.destroy_all
Ingredient.destroy_all

puts 'Ingredients DB cleaned'
puts '----------------------'
puts 'Creating cocktail ingredients'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients["drinks"].each do |ingredient|
  Ingredient.create!(name: ingredient["strIngredient1"])
end

10.times do
  cocktail = Cocktail.new(
    name: Faker::Beer.name
  )
  cocktail.save!
  3.times do
    dose = Dose.new(
      description: Faker::Number.between(from: 1, to: 10),
      ingredient: Ingredient.all.sample,
      cocktail_id: cocktail.id
    )
    dose.save!
  end
  puts "created #{cocktail.name} -- #{}"
end
puts 'Finished'
puts "#{Ingredient.count} ingredients created"

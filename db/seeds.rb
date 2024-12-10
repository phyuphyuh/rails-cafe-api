# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

puts "Removing all cafes from the DB..."
Cafe.destroy_all
puts "Getting the cafes from the JSON..."
seed_url = 'https://gist.githubusercontent.com/yannklein/5d8f9acb1c22549a4ede848712ed651a/raw/3daec24bcd833f0dd3bcc8cee8616a731afd1f37/cafe.json'
# Making an HTTP request to get back the JSON data
json_cafes = URI.open(seed_url).read
# Converting the JSON data into a ruby object (this case an array)
cafes = JSON.parse(json_cafes)
# iterate over the array of hashes to create instances of cafes
cafes.each do |cafe_hash|
  puts "Creating #{cafe_hash['title']}..."
  Cafe.create!(
    title: cafe_hash['title'],
    address: cafe_hash['address'],
    picture: cafe_hash['picture'],
    criteria: cafe_hash['criteria'],
    hours: cafe_hash['hours']
  )
end
puts "... created #{Cafe.count} cafes! ☕️"

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |i|
  vehicle = Vehicle.new(
    manufacture: Faker::Vehicle.manufacture,
    model: Faker::Vehicle.model,
    color: Faker::Vehicle.color,
    doors: Faker::Vehicle.doors,
    kilometrage: Faker::Vehicle.kilometrage,
    production_year: Faker::Date.between(from: 15.years.ago, to: Date.today).to_s
  )
  image_path = File.open Rails.root.join('test', 'fixtures', 'files', 'hexlet.jpg').to_s
  vehicle.image.attach(io: image_path, filename: "file#{i}.pdf")

  vehicle.save!
end
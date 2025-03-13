# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  p = Post.create(
    title: Faker::Name.name,
    body: Faker::Name.name
  )
  3.times do
    Post::Comment.create(
      body: Faker::Lorem.unique,
      post_id: p.id
    )
  end
end

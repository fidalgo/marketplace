# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email

puts "Environment: #{Rails.env}"

Worker.destroy_all
Costumer.destroy_all

Faker::Hipster.words(6).each do |skill|
  Skill.create(name: skill)
end

skills = Skill.all

(1..10).each do |n|
  worker = Worker.create!(name: "Worker #{n}", email: "worker#{n}@mk.pt",
                          password: 'foobaroo', password_confirmation: 'foobaroo')
  3.times { Skilling.create!(skill: skills.sample, worker: worker) }
end

Costumer.create!(name: 'Costumer', email: 'costumer@mk.pt',
                 password: 'foobaroo', password_confirmation: 'foobaroo')

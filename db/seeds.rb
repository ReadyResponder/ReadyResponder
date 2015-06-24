# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = ["Manager", "Editor", "Trainer", "Reader"].each do |role|
  Role.find_or_create_by_name({ name: role }, without_protection: true)
end

kgf = User.find_or_create_by_email({email: "kgf@example.com"}) do |k|
  k.password = "kgflims"
  k.password_confirmation = "kgflims"
  k.username = "kgf"
  k.firstname = "Kgf"
  k.lastname = "Lims"
end

kgf.roles << Role.first
kgf.save!(:validate => false)

p1 = Person.find_or_create_by_firstname({firstname: "Houhoulis"}) do |p|
  p.firstname = "Houhoulis"
  p.lastname = "Williams"
  p.status = "Active"
end

p2 = Person.find_or_create_by_firstname({firstname: "Thomas"}) do |p|
  p.firstname = "Thomas"
  p.lastname = "Carlson"
  p.status = "Applicant"
end

#seed user with admin privileges, a few other models
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# I have added some objects whose status is Inactive to ensure they don't appear.

manager_role = Role.find_or_create_by(name: "Manager")
if User.count == 0
  password = (0...6).map { ('a'..'z').to_a[rand(26)] }.join.upcase
  puts "The initial user password is #{password}"
  puts "The initial user name is 'bdoe@example.com'"
  admin_user = User.create(username: "bdoe",
                           email: "bdoe@example.com",
                           firstname: "Bob", lastname: "Doe",
                           password: password,
                           password_confirmation: password
                           )
  admin_user.roles << manager_role
end

Role.find_or_create_by(name: "Editor")
Role.find_or_create_by(name: "Author")
Role.find_or_create_by(name: "Depositor")
Role.find_or_create_by(name: "Trainer")
Role.find_or_create_by(name: "Admin")

# Departments are where people call home.
Department.create([
  {name: "Community Emergency Response Team", status: "Active", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]},
  {name: "Medical Reserve Corp", status: "Active", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]},
  {name: "Department Public Works", status: "Active", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]},
  {name: "Inactive Department", status: "Inactive", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]},
  {name: "Police", status: "Active", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]}
  ])

Skill.create([
  {name: "EMT-B", status: "Active"},
  {name: "First Responder First Aid", status: "Active"},
  {name: "Paramedic", status: "Active"},
  {name: "Drivers License", status: "Active"}
  ])

jane = Person.create(
   firstname: "Jane", lastname: "Doe", status: "Active", gender: "Female",
   start_date: 3.years.ago, department: "Medical Reserve Corp",
   nickname: "Janey", division1: "Division 1", division2: "Squad 2",
   icsid: "321", deployable: true
  )

jake = Person.create(
   firstname: "Jake", lastname: "D", status: "Active", gender: "Male",
   start_date: 1.years.ago, department: "Police",
   division1: "Division 1", division2: "Squad 1",
   icsid: "323", deployable: true
  )


# This should be updated when we can assign the department.
# Add department: Department.where(shortname: "DPW")
Location.create([
  {name: "Town Hall", status: "Active" },
  {name: "Building 2", status: "Active" },
  {name: "Inactive Location", status: "Inactive"}
  ])

# Create Association between departments and locations
location1 = Location.first
department1 = Department.where(name: "Community Emergency Response Team").first
location1.department = department1
location1.save

department2 = Department.where(name: "Department Public Works").first
other_location = Location.last(2)
other_location.each do |loc|
  loc.department = department2
  loc.save
end
# After we create ResourceTypes, we can create Items
ResourceType.create([
  {name: "HT Radio", description: "Handheld Radio", status: "Active", fema_code: "Unknown", fema_kind: "Unknown"}
  ])

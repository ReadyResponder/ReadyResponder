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
Role.find_or_create_by(name: "Reader")

# Departments are where people call home.
Department.create([
  {name: "Department Public Works", shortname: "DPW", status: "Active", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]},
  {name: "Inactive Department", shortname: "inactive", status: "Inactive", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]},
  {name: "Police", shortname: "BAUX", status: "Active", division1: ["Division 1", "Division 2"], division2: ["Squad 1", "Squad 2"]}
  ])
  cert = Department.create({name: "Community Emergency Response Team",
                            shortname: "CERT",
                            status: "Active",
                            manage_people: true,
                            manage_items: true,
                            division1: ["Division 1", "Division 2"],
                            division2: ["Squad 1", "Squad 2"]})
mrc = Department.create({name: "Medical Reserve Corp",
                          shortname: "MRC",
                          status: "Active",
                          manage_people: true,
                          division1: ["Division 1", "Division 2"],
                          division2: ["Team 1", "Team 2"]})
Skill.create([
  {name: "EMT-B", status: "Active"},
  {name: "First Responder First Aid", status: "Active"},
  {name: "Paramedic", status: "Active"},
  {name: "Drivers License", status: "Active"}
  ])

jane = Person.create(
   firstname: "Jane", lastname: "Doe", status: "Active", gender: "Female",
   start_date: 3.years.ago, department: mrc,
   nickname: "Janey", division1: "Division 1", division2: "Team 2",
   icsid: "321", deployable: true
  )

jake = Person.create(
   firstname: "Jake", lastname: "D", status: "Active", gender: "Male",
   start_date: 1.years.ago, department: cert,
   division1: "Division 1", division2: "Squad 1",
   icsid: "323", deployable: true
  )


# This should be updated when we can assign the department.
# Add department: Department.where(shortname: "DPW")
Location.create([
  {name: "Town Hall", status: "Active",
    department: cert },
  {name: "Building 2", status: "Active",
    department: Department.where(name: "Department Public Works").first },
  {name: "Inactive Location", status: "Inactive",
    department: Department.where(name: "Department Public Works").first }
  ])

# After we create ResourceTypes, we can create Items
ResourceType.create([
  {name: "HT Radio", description: "Handheld Radio", status: "Active", fema_code: "Unknown", fema_kind: "Unknown"}
  ])

Event.create([{ title: "Sample Event", status: "Scheduled", category: "Event",
                description: "Something to see", id_code: "howdy",
                start_time: 24.hours.from_now, end_time: 27.hours.from_now,
                is_template: false, departments: [cert]
                }])

comms = ItemCategory.find_or_create_by(name: "Communication") do |item|
          item.status = "Active",
          item.description = "Radios, antennae, telephones, repeaters and all assorted peripherals including microphones and earpieces."
        end

ht = comms.item_types.find_or_create_by(name: "Radio, Portable") do |item|
       item.status = "Active",
       item.description = "Handheld radios"
     end

Item.find_or_create_by(name: "Radio 1") do |item|
  item.item_type_id = ht.id,
  item.department_id = mrc.id,
  item.name = "Radio 1",
  item.status = "Unassigned",
  item.condition = "Ready",
  item.brand = "Motorola",
  item.model = "HT-1000",
  item.qty = 1
end

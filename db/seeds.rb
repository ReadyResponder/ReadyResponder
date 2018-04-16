# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# I have added some objects whose status is Inactive to ensure they don't appear.

# Roles & Admin User
manager_role = Role.find_or_create_by(name: 'Manager')
  if User.count == 0
    password = (0...6).map { ('a'..'z').to_a[rand(26)] }.join.upcase
    puts "The initial user password is #{password}"
    puts "The initial user name is 'bdoe@example.com'"
    admin_user = User.create(username: 'bdoe',
                             email: 'bdoe@example.com',
                             firstname: 'Bob', lastname: 'Doe',
                             password: password,
                             password_confirmation: password
                             )
    admin_user.roles << manager_role
  end

  Role.find_or_create_by(name: 'Editor')
  Role.find_or_create_by(name: 'Author')
  Role.find_or_create_by(name: 'Depositor')
  Role.find_or_create_by(name: 'Trainer')
  Role.find_or_create_by(name: 'Admin')
  Role.find_or_create_by(name: 'Reader')

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
   icsid: "321", deployable: true, title: 'Recruit'
  )

jake = Person.create(
   firstname: "Jake", lastname: "D", status: "Active", gender: "Male",
   start_date: 1.years.ago, department: cert,
   division1: "Division 1", division2: "Squad 1",
   icsid: "323", deployable: true, title: 'Deputy'
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
                is_template: false, departments: [cert], min_title: "Recruit"
                }])

comms = ItemCategory.find_or_create_by(name: "Communication") do |item_cat|
  item_cat.status = "Active"
  item_cat.description = "Radios, antennae, telephones, repeaters and all assorted peripherals including microphones and earpieces."
end

ht = ItemType.find_or_create_by(name: "Radio, Portable") do |item_type|
  item_type.item_category = comms
  item_type.status = "Active"
  item_type.description = "Handheld radios"
end


tmp_grant = Grant.find_or_initialize_by(name: "foo-grant").tap do |grant|
  base_attrs = {
    description: 'Donated a collection of 200 books by XYZ publications',
    start_date: '12-12-2012',
    end_date: '10-10-2017',
    status: 'Active'
  }
  grant.update(base_attrs)
end

Item.find_or_create_by(name: "Radio 1") do |item|
  item.item_type = ht
  item.department = mrc
  item.name = "Radio 1"
  item.status = "Unassigned"
  item.condition = "Ready"
  item.brand = "Motorola"
  item.model = "HT-1000"
  item.qty = 1
  item.grant_id = tmp_grant.id
end

Setting.find_or_create_by(key: 'TIMECARD_MAXIMUM_HOURS') do |setting|
  setting.name = 'Timecard maximum hours'
  setting.description = 'Number of hours from start_time after which timecards with no end_time and Incomplete status are considered stale and marked as Error.'
  setting.value = 24
  setting.category = 'Timecard'
  setting.status = 'Active'
  setting.required = true
end

Setting.find_or_create_by(key: 'UPCOMING_EVENTS_COUNT') do |setting|
  setting.name = 'Upcoming events count'
  setting.description = 'No of upcoming events to be displayed'
  setting.value = 10
  setting.category = 'Person'
  setting.status = 'Active'
  setting.required = true
end
<<<<<<< HEAD
=======

# SEEDS NEEDED:
# activities
          # - <content: nil, author: nil, loggable_id: nil, loggable_type: nil>
# assignments
          # - <person_id: nil, requirement_id: nil, start_time: nil, end_time: nil, status: nil, duration: nil>
# availabilities
          # - <start_time: nil, end_time: nil, status: nil, description: nil, person_id: nil>
# certs
          # - <person_id: nil, course_id: nil, status: nil, category: nil, level: nil, cert_number: nil, issued_date: nil, expiration_date: nil, comments: nil, updated_by: nil, created_by: nil, grade: nil, event_id: nil, certification: nil>
# channels
          # - <person_id: nil, name: nil, status: nil, content: nil, priority: nil, category: nil, carrier: nil, last_verified: nil, usage: nil, channel_type: nil, sms_available: false, type: nil>
# comments
          # - <title: "", description: nil, commentable_id: nil, commentable_type: nil, person_id: nil>
# courses
          # - < name: nil, status: nil, description: nil, comments: nil, category: nil, duration: nil, term: nil>
# events
          # * only one.. should be two
# grants
          # * only one.. should be two
# helpdocs
          # (??)
# inspections
          # - <item_id: nil, person_id: nil, inspection_date: nil, mileage: nil, repair_needed: nil, status: nil, comments: nil, category: nil>
# item_types
          # * only one.. should be two
# items
          # * only one.. should be two
# messages
          # - <subject: nil, status: nil, body: nil, sent_at: nil, recipient_id: nil, channel_id: nil>
# moves
          # - <item_id: nil, locatable_id: nil, locatable_type: nil, comments: nil, reason: nil>
# notifications
          # - <event_id: nil, author_id: nil, status: nil, time_to_live: nil, interval: nil, iterations_to_escalation: nil, scheduled_start_time: nil, start_time: nil, channels: nil, groups: nil, departments: nil, divisions: nil, subject: nil, body: nil, purpose: nil>
# questions
          # - <prompt: nil, response_choices: nil, category: nil, status: nil, comments: nil>
# recipients
          # - <notification_id: nil, person_id: nil, status: nil, response_channel: nil, response_time: nil>
# repairs
          # - <item_id: nil, user_id: nil, person_id: nil, category: nil, service_date: nil, status: nil, description: nil, comments: nil, cost: nil>
# requirements
          # - <task_id: nil, skill_id: nil, title_id: nil, priority: nil, minimum_people: nil, maximum_people: nil, desired_people: nil, floating: nil, optional: nil>
# resource_types
          # * only one.. should be two
# tasks
          # - <event_id: nil, title: nil, description: nil, street: nil, city: nil, state: nil, zipcode: nil, latitude: nil, longitude: nil, start_time: nil, end_time: nil, location: nil, priority: nil, status: nil>
# - timecards
          # - <person_id: nil, start_time: nil, end_time: nil, duration: nil, comments: nil, error_code: nil, description: nil, status: nil>
# - titles
          # - <name: nil, status: nil, description: nil, comments: nil>
# - versions (??)

# JOINS
# - inspections_questions
# - departments_events
# - departments_notifications
# - courses_skills
# - roles_users
# - skills_titles
# - peoples_titles
>>>>>>> 683d9e2a853bc02ec4590844931f228e47623b5f

require 'test_helper'

class PersonTest < ActiveSupport::TestCase


  test "address state must be equal to 2 characters" do
    person = Person.new(firstname: "CJ",
                        lastname: "Fallon",
                        status: "Active",
                        state: "M")
    assert person.invalid?, "state too short"
    person.state = "Mass"
    assert person.invalid?, "stat too long"
    person.state = "MA"
    assert person.valid?
  end

  test "division 1 and division 2 must be valid" do
    person = Person.new(firstname: "CJ",
                        lastname: "Fallon",
                        status: "Active",
                        division1: "Command")
    assert person.invalid?, "division2 blank when division1 entered should be invalid"
    person.division1 = ""
    person.division2 = "Command"
    assert person.invalid?, "division1 blank when division2 entered should be invalid"
    person.division1 = "Command"
    assert person.valid?
  end

  test "icsid (badge) should be unique" do
    person1 = Person.new(firstname: "CJ",
                         lastname: "Fallon",
                         status: "Active")
    person2 = Person.new(firstname: "CJ",
                         lastname: "Fallon",
                         status: "Active")
    person1.icsid = "509"
    person1.save!
    person2.icsid = "509"
    assert person2.invalid?, " ICSID badge duplicated."
    person2.icsid = "555"
    assert person2.valid?
  end
  
end

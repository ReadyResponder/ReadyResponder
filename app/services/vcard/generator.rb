module Vcard
  class Generator
    VERSION = '3.0'
    attr_reader :person, :vcard
    def self.call(person)
      new(person).call
    end

    def initialize(person)
      @person = person
    end

    def call
      @vcard = VCardigan.create(version: VERSION)
      vcard.name person.firstname, person.lastname, '', gender_abbr
      vcard.fullname person.fullname
      vcard.email person.email
      vcard.bday person.date_of_birth.strftime("%Y%m%d")
      vcard.title person.department.name
      generate_phones

      vcard
    end

    private

    def generate_phones
      person.phones.each do |phone|
        vcard.tel phone.content, type: phone.category
      end
    end

    def gender_abbr
      person.gender == 'Male' ? 'Mr.' : 'Mrs.'
    end
  end
end

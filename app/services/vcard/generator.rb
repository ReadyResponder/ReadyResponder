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
      vcard.name person.firstname, person.lastname
      vcard.fullname person.fullname
      vcard.email person.email
      vcard.org person.department.name
      generate_phones

      vcard
    end

    private

    def generate_phones
      person.phones.each do |phone|
        vcard.tel phone.content, type: phone.category
      end
    end
  end
end

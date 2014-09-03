require 'spec_helper'

describe Person do

  describe "search" do
    it "should return a person with the same firstname" do
      FactoryGirl.create(:person, :firstname => "John")
      FactoryGirl.create(:person, :firstname => "Jane")
      expect(Person.search("John").count).to eq(1)
    end

    it "should return a person with the same lastname" do
      FactoryGirl.create(:person, :lastname => "Doe")
      FactoryGirl.create(:person, :lastname => "Stag")
      expect(Person.search("Doe").count).to eq(1)
    end

    it "should return a person with the same id" do
      FactoryGirl.create(:person, :icsid => "123")
      FactoryGirl.create(:person, :icsid => "23")
      expect(Person.search("123").count).to eq(1)
    end
  end

end

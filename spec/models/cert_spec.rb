require 'rails_helper'

RSpec.describe Cert do
  let(:evoc_course) { create(:course, term: 100) }
  subject { create :cert, course: evoc_course }

  it 'sets the issued date to today' do # This is set in the factory
    expect(subject.issued_date).to be == Date.today
  end

  it 'sets the expiration date properly' do
    expect(subject.expiration_date).to be == Date.today + evoc_course.term.to_i.months
  end

  it "requires expiration_date to be after issued_date" do #chronology
    @cert = build(:cert, course: evoc_course, issued_date: 2.days.from_now, expiration_date: 2.days.ago)
    expect(@cert).not_to be_valid
  end

end

require 'spec_helper'

describe Cert do
  let(:evoc_course) { create(:course, term: 100) }
  subject { create :cert, course: evoc_course }

  it 'sets the issued date to today' do
    expect(subject.issued_date).to be == Date.today
  end

  it 'sets the expiration date properly' do
    expect(subject.expiration_date).to be == Date.today + evoc_course.term.to_i.months
  end
end

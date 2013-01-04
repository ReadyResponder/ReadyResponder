require 'spec_helper'

describe "attendances/edit" do
  before(:each) do
    @attendance = assign(:attendance, stub_model(Attendance,
      :person_id => 1,
      :event_id => 1,
      :category => "MyString",
      :duration => "9.99"
    ))
  end

  it "renders the edit attendance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => attendances_path(@attendance), :method => "post" do
      assert_select "input#attendance_person_id", :name => "attendance[person_id]"
      assert_select "input#attendance_event_id", :name => "attendance[event_id]"
      assert_select "input#attendance_category", :name => "attendance[category]"
      assert_select "input#attendance_duration", :name => "attendance[duration]"
    end
  end
end

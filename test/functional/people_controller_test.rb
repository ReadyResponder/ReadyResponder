require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = FactoryGirl.create(:person, icsid: "509")

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

    
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { firstname: @person.firstname, lastname: @person.lastname, status: @person.status }
    end
    assert_redirected_to people_path
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    put :update, id: @person, person: { firstname: @person.firstname, lastname: @person.lastname, status: @person.status }
    #assert_redirected_to person_path(assigns(:person))
    assert_redirected_to people_path
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end
    assert_redirected_to people_path
  end
  test "should only show active cert" do
    
  end
end

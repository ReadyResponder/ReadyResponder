require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
  setup do
    @title = FactoryBot.create(:title, name: "Police Officer")
    @skill = FactoryBot.create(:skill, name: "Driving")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skill" do
    assert_difference('Skill.count') do
      post :create, skill: { status: @skill.status, name: @skill.name }
    end

    assert_redirected_to skills_path
  end

  test "should show skill" do
    get :show, id: @skill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skill
    assert_response :success
  end

  test "should update skill" do
    put :update, id: @skill, skill: {status: @skill.status, name: @skill.name }
    
    assert_redirected_to skills_path
  end

  test "should destroy skill" do
    assert_difference('Skill.count', -1) do
      delete :destroy, id: @skill
    end

    assert_redirected_to skills_path
  end
end

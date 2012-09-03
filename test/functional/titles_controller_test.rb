require 'test_helper'

class TitlesControllerTest < ActionController::TestCase
  setup do
    @title = titles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:titles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create title" do
    assert_difference('Title.count') do
      post :create, title: { comments: @title.comments, description: @title.description, status: @title.status, title: @title.title }
    end

    assert_redirected_to title_path(assigns(:title))
  end

  test "should show title" do
    get :show, id: @title
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @title
    assert_response :success
  end

  test "should update title" do
    put :update, id: @title, title: { comments: @title.comments, description: @title.description, status: @title.status, title: @title.title }
    assert_redirected_to title_path(assigns(:title))
  end

  test "should destroy title" do
    assert_difference('Title.count', -1) do
      delete :destroy, id: @title
    end

    assert_redirected_to titles_path
  end
end

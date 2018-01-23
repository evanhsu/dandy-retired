require 'test_helper'

class CrewmembersControllerTest < ActionController::TestCase
  setup do
    @crewmember = crewmembers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crewmembers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crewmember" do
    assert_difference('Crewmember.count') do
      post :create, :crewmember => @crewmember.attributes
    end

    assert_redirected_to crewmember_path(assigns(:crewmember))
  end

  test "should show crewmember" do
    get :show, :id => @crewmember.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @crewmember.to_param
    assert_response :success
  end

  test "should update crewmember" do
    put :update, :id => @crewmember.to_param, :crewmember => @crewmember.attributes
    assert_redirected_to crewmember_path(assigns(:crewmember))
  end

  test "should destroy crewmember" do
    assert_difference('Crewmember.count', -1) do
      delete :destroy, :id => @crewmember.to_param
    end

    assert_redirected_to crewmembers_path
  end
end

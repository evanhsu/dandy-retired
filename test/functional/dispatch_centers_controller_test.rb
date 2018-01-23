require 'test_helper'

class DispatchCentersControllerTest < ActionController::TestCase
  setup do
    @dispatch_center = dispatch_centers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dispatch_centers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dispatch_center" do
    assert_difference('DispatchCenter.count') do
      post :create, :dispatch_center => @dispatch_center.attributes
    end

    assert_redirected_to dispatch_center_path(assigns(:dispatch_center))
  end

  test "should show dispatch_center" do
    get :show, :id => @dispatch_center.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dispatch_center.to_param
    assert_response :success
  end

  test "should update dispatch_center" do
    put :update, :id => @dispatch_center.to_param, :dispatch_center => @dispatch_center.attributes
    assert_redirected_to dispatch_center_path(assigns(:dispatch_center))
  end

  test "should destroy dispatch_center" do
    assert_difference('DispatchCenter.count', -1) do
      delete :destroy, :id => @dispatch_center.to_param
    end

    assert_redirected_to dispatch_centers_path
  end
end

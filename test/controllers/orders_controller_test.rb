require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { custom_field_authorized_buyer: @order.custom_field_authorized_buyer, custom_field_status: @order.custom_field_status, duedate: @order.duedate, expected_drive: @order.expected_drive, is_fully_received: @order.is_fully_received, is_manually_closed: @order.is_manually_closed, ref_number: @order.ref_number, time_created: @order.time_created, time_modified: @order.time_modified, total_amount: @order.total_amount }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { custom_field_authorized_buyer: @order.custom_field_authorized_buyer, custom_field_status: @order.custom_field_status, duedate: @order.duedate, expected_drive: @order.expected_drive, is_fully_received: @order.is_fully_received, is_manually_closed: @order.is_manually_closed, ref_number: @order.ref_number, time_created: @order.time_created, time_modified: @order.time_modified, total_amount: @order.total_amount }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end

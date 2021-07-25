# frozen_string_literal: true

require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test 'logged in user should get to dashboard page' do
    get root_url
    assert_select 'a', text: 'Login'
    get new_user_session_url
    assert_select 'h2', text: 'Log in'
    post new_user_session_url
    assert_response :success
    assert_select 'h2', text: 'Log in'
    sign_in @user
    post new_user_session_url
    assert_response :redirect
    get admin_profile_url
    assert_select 'h1', text: 'Dashboard - 	My Profile'
    assert_select 'a', text: 'My Profile'
  end

  test "logged in user should get create contact page" do
    get root_url
    get new_user_session_url
    post new_user_session_url
    assert_response :success
    assert_select 'h2', text: 'Log in'
    sign_in @user
    post new_user_session_url
    assert_response :redirect
    get admin_create_contact_path
    assert_response :success
    assert_select 'h1', text: 'Dashboard - 	Create Contact'
  end

  test "logged in user should get contact list page" do
    get root_url
    get new_user_session_url
    post new_user_session_url
    assert_response :success
    assert_select 'h2', text: 'Log in'
    sign_in @user
    post new_user_session_url
    assert_response :redirect
    get admin_contact_list_path
    assert_response :success
    assert_select 'h1', text: 'Dashboard - 	Contact List'
  end
end

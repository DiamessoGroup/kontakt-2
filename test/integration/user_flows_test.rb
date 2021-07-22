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
    sign_in @user
    post new_user_session_url
    assert_response :redirect
    get admin_profile_url
    assert_select 'h1', text: 'Dashboard - 	My Profile'
    assert_select 'a', text: 'My Profile'
  end
end

# frozen_string_literal: true

require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'logged in user should see profile page' do
    sign_in @user
    get admin_profile_path
    assert_response :success
  end

  test 'not logged in user should not see profile page' do
    get admin_profile_path
    assert_redirected_to new_user_session_path
  end

  test 'logged in user should get create contact page' do
    sign_in @user
    get admin_create_contact_path
    assert_response :success
  end

  test 'not logged in user should not get create contact page' do
    get admin_create_contact_path
    assert_redirected_to new_user_session_path
  end
end

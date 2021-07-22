# frozen_string_literal: true

require 'test_helper'

class AppControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test 'should get root' do
    get root_url
    assert_response :success
  end

  test 'should get about' do
    get app_about_url
    assert_response :success
  end

  test 'should redirect admin link to login when not logged in' do
    get admin_profile_path
    assert_redirected_to user_session_path
  end

  test "should redirect to admin page when logged in" do
    sign_in @user
    get admin_profile_path
    assert_response :success
  end
end

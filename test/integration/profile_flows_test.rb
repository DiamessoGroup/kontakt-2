# frozen_string_literal: true

require 'test_helper'

class ProfileFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @mike = users(:mike)
  end

  test 'should not create profile when first_name or last_name blank' do
    sign_in @mike
    assert_nil @mike.profile
    get admin_profile_path
    assert_response :success
    assert_no_difference 'Profile.count' do
      post user_profiles_path(@mike), params: { profile: { first_name: '', last_name: 'Freeman' } }, xhr: true
    end
    assert_select 'li', /First name can't be blank/
    assert_no_difference 'Profile.count' do
      post user_profiles_path(@mike), params: { profile: { first_name: 'Mike', last_name: '' } }, xhr: true
    end
    assert_select 'li', /Last name can't be blank/
    assert_equal "create", @controller.action_name

    assert_difference 'Profile.count', +1 do
      post user_profiles_path(@mike), params: { profile: { first_name: 'Mike', last_name: 'Freeman' } }, xhr: true
    end
    assert_equal "Your Profile was successfully created.", flash[:success]

    assert_redirected_to admin_profile_path
    assert_not_empty flash
  end

  #  TODO Integration Flow Profile updated
  # https://guides.rubyonrails.org/testing.html#system-testing
end

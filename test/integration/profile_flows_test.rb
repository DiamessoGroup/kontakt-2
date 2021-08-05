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

  test 'should not update profile when first_name or last_name blank' do
    sign_in @mike
    @mike.create_profile(first_name: "Mike", last_name: "Freeman")

    assert_equal(@mike.profile.first_name, "Mike")
    assert_equal(@mike.profile.last_name, "Freeman")

    assert_no_difference 'Profile.count' do
      patch user_profile_path(@mike, @mike.profile), params: { profile: { first_name: '', last_name: 'Freeman' } }, xhr: true
    end
    assert_select 'li', /First name can't be blank/
    assert_no_difference 'Profile.count' do
      patch user_profile_path(@mike, @mike.profile), params: { profile: { first_name: 'Mike', last_name: '' } }, xhr: true
    end
    assert_select 'li', /Last name can't be blank/
    assert_equal "update", @controller.action_name

    assert_no_difference 'Profile.count' do
      patch user_profile_path(@mike, @mike.profile), params: { profile: { first_name: 'Ben', last_name: 'Wallace', title: "Developer" } }, xhr: true
    end

    @mike.profile.reload
    assert_equal(@mike.profile.first_name, "Ben")
    assert_equal(@mike.profile.last_name, "Wallace")
    assert_equal(@mike.profile.title, "Developer")

    assert_redirected_to admin_profile_path
    assert_not_empty flash
  end
end

# frozen_string_literal: true

require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
    @john = users(:john)
    @mike = users(:mike)
  end

  test 'should redirect create profile when not logged in' do
    get admin_profile_path
    assert_redirected_to new_user_session_path
    assert_no_difference 'Profile.count' do
      post user_profiles_path(@john),
           params: { profile: { first_name: @profile.first_name, last_name: @profile.last_name } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should create profile when logged in' do
    sign_in @mike
    get admin_profile_path
    assert_response :success
    assert_difference 'Profile.count' do
      post user_profiles_path(@mike), params: { profile: { first_name: 'Mike', last_name: 'Freeman' } }
    end
    assert_redirected_to admin_profile_path
  end

  test 'should redirect update profile when not logged in' do
    get admin_profile_path
    assert_redirected_to new_user_session_path
    assert_no_difference 'Profile.count' do
      patch user_profile_path(@john, @profile), params: { profile: { first_name: 'Joseph', last_name: 'Valenzuela' } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should update profile when logged in' do
    sign_in @mike
    get admin_profile_path
    assert_response :success
    assert_difference 'Profile.count' do
      post user_profiles_path(@mike), params: { profile: { first_name: 'Mike', last_name: 'Freeman' } }
    end
    assert_redirected_to admin_profile_path
    assert_equal(Profile.last.first_name, 'Mike')
    assert_no_difference 'Profile.count' do
      patch user_profile_path(@mike, Profile.last),
            params: { profile: { first_name: 'Joseph', last_name: 'Valenzuela' } }
    end
    assert_redirected_to admin_profile_path
    # Ensures that expected == actual is true.
    assert_equal(Profile.last.first_name, 'Joseph')
  end

  test 'new user should onboard' do
    get admin_profile_url
    assert_redirected_to new_user_session_url
    get new_user_registration_url
    assert_response :success
    assert_difference 'User.count', +1 do
      post user_registration_path,
           params: { user: { email: 'stevejobs@apple.com', password: 'stevejobs', password_confirmation: 'stevejobs' } }
    end
    assert_redirected_to admin_onboarding_url
    assert_no_difference 'Profile.count' do
      post admin_onboarding_url,
           params: { profile: { first_name: 'Steve', last_name: '' } }
    end

    assert_template 'profiles/onboarding'

    assert_difference 'Profile.count', +1 do
      post admin_onboarding_url,
           params: { profile: { first_name: 'Steve', last_name: 'jobs' } }
    end

    assert_redirected_to admin_profile_url
  end
end

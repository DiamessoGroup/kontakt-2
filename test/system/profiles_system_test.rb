# frozen_string_literal: true

require 'application_system_test_case'

class ProfilesSystemTest < ApplicationSystemTestCase
  def setup
    @mike = users(:mike)
    @john = users(:john)
    @johnprofile = profiles(:one)
  end

  test 'creating a profile' do
    sign_in @mike
    visit admin_profile_url
    assert_selector 'h1', text: 'Dashboard - My Profile'
    click_on('Create Profile')

    fill_in('First name', with: 'Willard')
    fill_in('Last name', with: 'Acosta')
    fill_in('Title', with: 'Project Manager')
    fill_in('Company', with: 'Tesla')
    fill_in('Phone', with: '554-523-0066')
    fill_in('Address', with: '3251 Bernardo Street')
    fill_in('City', with: 'Tampa')
    fill_in('State', with: 'FL')
    fill_in('Zip code', with: '10014')

    click_button('Create Profile')

    assert_text 'Your Profile was successfully created.'
    assert_selector 'span', text: 'Project Manager'
    # save_and_open_screenshot
  end

  test 'updating a profile' do
    sign_in @john
    visit admin_profile_url
    assert_selector 'h1', text: 'Dashboard - My Profile'
    click_on('Edit Profile')

    fill_in('First name', with: 'Joan')
    fill_in('Last name', with: 'Lankford')
    fill_in('Title', with: 'Tax Preparor')
    click_button('Update Profile')

    assert_text 'Your Profile was successfully updated.'
    assert_selector 'span', text: 'Tax Preparor'
    # page.save_screenshot('update_screenshot.png')
    take_screenshot
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class ProfilesTest < ApplicationSystemTestCase
  def setup
    @mike = users(:mike)
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
  end
end

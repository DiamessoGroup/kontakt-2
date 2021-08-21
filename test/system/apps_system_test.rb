require 'application_system_test_case'

class AppsSystemTest < ApplicationSystemTestCase

  def setup
    @john = users(:john)
  end

  test 'visiting the root' do
    visit root_url
    assert_selector 'h1', text: 'Vertically centered hero sign-up form'
  end

  test 'has home link' do
    visit root_url
    assert_selector 'a', text: 'Home'
  end

  test 'should navigate to login page' do
    visit root_url
    assert_selector 'a', text: 'Login'
    click_on 'Login'
    assert_selector 'h2', text: 'Log in'
  end

  test 'visiting the admin profile page' do
    sign_in @john
    visit admin_profile_url
    assert_selector 'h1', text: 'Dashboard - My Profile'
  end

  test 'visiting the create contact page' do
    sign_in @john
    visit new_user_contact_url(@john)
    assert_selector 'h1', text: 'Dashboard - Create Contact'
  end

  test 'visiting the contact list page' do
    sign_in @john
    visit user_contacts_url(@john)
    assert_selector 'h1', text: 'Dashboard - Contact List'
  end

  test 'not logged in user visiting the admin profile page should be redirected to login page' do
    visit admin_profile_url
    assert_selector 'h2', text: 'Log in'
  end

end

require 'application_system_test_case'

class AppsTest < ApplicationSystemTestCase

  def setup
    @user = users(:john)
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
    sign_in @user
    visit admin_profile_url
    assert_selector 'h1', text: 'Dashboard - My Profile'
  end

  test 'visiting the create contact page' do
    sign_in @user
    visit admin_create_contact_url
    assert_selector 'h1', text: 'Dashboard - Create Contact'
  end

end

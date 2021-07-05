require 'application_system_test_case'

class AppsTest < ApplicationSystemTestCase
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

end

require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  def setup
    @mike = users(:mike)
  end

  test "creating a profile" do
    sign_in @mike
    visit admin_profile_url
    assert_selector 'h1', text: 'Dashboard - My Profile'
    click_on 'Edit Profile'
  end
end

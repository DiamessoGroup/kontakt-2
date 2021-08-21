# frozen_string_literal: true

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def setup
    @mike = users(:mike)
  end

  test 'profile should not be valid if first_name is empty' do
    @profile = @mike.build_profile(first_name: ' ')
    assert_not @profile.valid?
  end

  test 'profile should not be valid if last_name is empty' do
    @profile = @mike.build_profile(last_name: ' ')
    assert_not @profile.valid?
  end

  test 'profile should be valid when last_name and first_name present' do
    @profile = @mike.build_profile(first_name: 'Mike', last_name: 'Solomon')
    assert @profile.valid?
  end

  test 'profile should not be created when last_name and first_name not present' do
    @profile = @mike.build_profile(first_name: '', last_name: '')
    assert_no_difference 'Profile.count' do
      @profile.save
    end
  end

  test 'profile should be created when last_name and first_name present' do
    @profile = @mike.build_profile(first_name: 'Mike', last_name: 'Solomon')
    assert_difference 'Profile.count' do
      @profile.save
    end
  end

  test "profile should not be updated when last_name or first_name not present" do
    assert_difference "Profile.count", +1 do
      @mike.create_profile(first_name: "Mike", last_name: "Solomon")
    end

    assert_no_difference "Profile.count" do
      @mike.profile.update(first_name: "", last_name: "Solomon", title: "Engineer")
    end
  end

end

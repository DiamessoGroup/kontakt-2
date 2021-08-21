# frozen_string_literal: true

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  def setup
    @john = users(:john)
    @john_contact_jeff = contacts(:jeff)
  end

  test 'contact without first_name should not be valid' do
    @contact = @john.contacts.build(first_name: '')
    assert_not @contact.valid?
  end

  test 'contact without last_name should not be valid' do
    @contact = @john.contacts.build(last_name: '')
    assert_not @contact.valid?
  end

  test 'contact with first_name and last_name should be valid' do
    @contact = @john.contacts.build(first_name: 'Timothy', last_name: 'Peterson')
    assert @contact.valid?
  end

  test 'contact should not be created when last_name and first_name not present' do
    @contact = @john.contacts.build(first_name: '', last_name: '')
    assert_no_difference 'Contact.count' do
      @contact.save
    end
  end

  test 'contact should be created when last_name and first_name present' do
    @contact = @john.contacts.build(first_name: 'Mike', last_name: 'Solomon')
    assert_difference 'Contact.count' do
      @contact.save
    end
  end
end

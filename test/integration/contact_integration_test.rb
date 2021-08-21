# frozen_string_literal: true

require 'test_helper'

class ContactIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @john = users(:john)
    @john_contact_jeff = contacts(:jeff)
  end

  test 'user should create contact when logged in' do
    sign_in @john
    assert_difference '@john.contacts.count' do
      post user_contacts_url(@john),
           params: { contact: { first_name: 'Timothy', last_name: 'Lin', email: 'TimothyBLin@dayrep.com',
                                phone: '304-536-1164',
                                address: '2159 Columbia Mine Road, White Sulphur Spring, WV 24986',
                                title: 'Career counselor', company: 'Dream Home Improvements', favorite: false } }
    end
    assert_equal 'Your Contact was successfully created.', flash[:success]

    assert_response :redirect
    assert_equal 'create', @controller.action_name

    follow_redirect!
    assert_select 'td', text: 'Timothy'
    assert_equal @john.contacts.where(first_name: "Jeff").count, 1
    # All of John contacts are listed
    @john.contacts.paginate(page: 1).each do |contact|
      assert_select 'td', contact.first_name
    end
  end

  test 'user should delete contact when logged in' do
    sign_in @john
    assert_difference '@john.contacts.count', -1 do
      delete user_contact_url(@john, @john_contact_jeff)
    end
    assert_equal 'Your contact was successfully deleted.', flash[:success]
    assert_response :redirect
    assert_equal 'destroy', @controller.action_name

    follow_redirect!
    # Jeff is erased. There is no row with a first name of Jeff
    assert_select 'td', text: 'Jeff', count: 0
    assert_equal @john.contacts.where(first_name: "Jeff").count, 0
  end
end

# frozen_string_literal: true

require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @john = users(:john)
    @john_contact_jeff = contacts(:jeff)
  end

  test 'User Not logged in is redirected and should not see contact list' do
    get user_contacts_url(@john)
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'Signed in user should see contact list' do
    sign_in @john
    get user_contacts_url(@john)
    assert_response :success
  end

  test 'User Not logged in is redirected and should not see contact profile' do
    get user_contact_url(@john, @john_contact_jeff)
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'Signed in user should see contact profile' do
    sign_in @john
    get user_contact_url(@john, @john_contact_jeff)
    assert_response :success
  end

  test 'User Not logged in is redirected and should not create new contact' do
    get new_user_contact_url(@john)
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'Signed in user should create contact form' do
    sign_in @john
    get new_user_contact_url(@john)
    assert_response :success
  end

  test 'user not logged in should be redirected to login page when trying to create new contact' do
    assert_no_difference '@john.contacts.count' do
      post user_contacts_url(@john),
           params: { contact: { first_name: 'Timothy', last_name: 'Lin', email: 'TimothyBLin@dayrep.com',
                                phone: '304-536-1164',
                                address: '2159 Columbia Mine Road, White Sulphur Spring, WV 24986',
                                title: 'Career counselor', company: 'Dream Home Improvements', favorite: false } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'create should not created if first_name is missing' do
    sign_in @john
    assert_no_difference '@john.contacts.count' do
      post user_contacts_url(@john),
           params: { contact: { first_name: '', last_name: 'Lin', email: 'TimothyBLin@dayrep.com',
                                phone: '304-536-1164',
                                address: '2159 Columbia Mine Road, White Sulphur Spring, WV 24986',
                                title: 'Career counselor', company: 'Dream Home Improvements', favorite: false } }
    end
    assert_template 'contacts/new'
  end

  test 'user is logged in and should create new contact' do
    sign_in @john
    assert_difference '@john.contacts.count' do
      post user_contacts_url(@john),
           params: { contact: { first_name: 'Timothy', last_name: 'Lin', email: 'TimothyBLin@dayrep.com',
                                phone: '304-536-1164',
                                address: '2159 Columbia Mine Road, White Sulphur Spring, WV 24986',
                                title: 'Career counselor', company: 'Dream Home Improvements', favorite: false } }
    end
    assert_response :redirect
    assert_redirected_to user_contacts_path
    follow_redirect!
    @john.contacts.reload
    # Ensures that expected == actual is true.
    assert_equal('Timothy', @john.contacts.last.first_name)
  end

  test 'user not logged in should be redirected when trying to update a contact' do
    patch user_contact_url(@john, @john_contact_jeff), params: { contact: { first_name: 'Joseph' } }

    assert_redirected_to new_user_session_path
  end

  test 'user should update contact when logged in' do
    sign_in @john
    patch user_contact_url(@john, @john_contact_jeff), params: { contact: { first_name: 'Joseph' } }
    assert_redirected_to user_contact_url(@john, @john_contact_jeff)
    @john_contact_jeff.reload
    # Ensures that expected == actual is true.
    assert_equal('Joseph', @john_contact_jeff.first_name)
  end

  test 'contact should not update when first_name is not present' do
    sign_in @john
    patch user_contact_url(@john, @john_contact_jeff), params: { contact: { first_name: ' ' } }
    assert_template 'contacts/edit'
    @john_contact_jeff.reload
    # Ensures that expected == actual is true.
    assert_equal('Jeff', @john_contact_jeff.first_name)
  end

  test 'user should delete contact successfully when logged in' do
    sign_in @john
    assert_difference '@john.contacts.count', -1 do
      delete user_contact_url(@john, @john_contact_jeff)
    end
    assert_redirected_to user_contacts_url
  end

  test 'user should not delete contact successfully when not logged in' do
    assert_no_difference '@john.contacts.count' do
      delete user_contact_url(@john, @john_contact_jeff)
    end
    assert_redirected_to new_user_session_path
  end

  test 'user not logged in should not be able to search' do
    get contacts_search_url
    assert_response :redirect
  end

  test 'search bar should return contacts with query' do
    sign_in @john
    get contacts_search_url
    assert_response :success
    assert_template 'contacts/search'
  end
end

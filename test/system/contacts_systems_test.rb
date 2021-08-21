# frozen_string_literal: true

require 'application_system_test_case'

class ContactsSystemsTest < ApplicationSystemTestCase
  def setup
    @john = users(:john)
    @john_contact_jeff = contacts(:jeff)
  end

  test 'visiting the contact list' do
    sign_in @john
    visit user_contacts_url(@john)
    take_screenshot
    assert_selector 'h1', text: 'Dashboard - Contact List'
    assert_text @john_contact_jeff.first_name.to_s, count: 1
  end

  test 'creating a new contact' do
    sign_in @john
    visit new_user_contact_url(@john)
    assert_selector 'h1', text: 'Dashboard - Create Contact'

    fill_in('First Name', with: 'Arminda')
    fill_in('Last Name', with: 'Clay')
    fill_in('Title', with: 'Project Manager')
    fill_in('Company', with: 'Tesla')
    fill_in('Phone', with: '508-789-6071')
    fill_in('Address', with: '1728 Smith Street, West Roxbury, MA 02132')
    click_button 'Create Contact'

    assert_selector 'h1', text: 'Dashboard - Contact List'
    assert_text 'Arminda', count: 1
  end

  test 'deleting a contact' do
    sign_in @john
    visit user_contact_url(@john, @john_contact_jeff)
    assert_selector 'h1', text: 'Dashboard - View Contact'

    accept_alert do
      click_on 'Delete Contact'
    end

    assert_selector 'h1', text: 'Dashboard - Contact List'
    assert_text 'Jeff', count: 0
  end

  test 'searching a contact' do
    sign_in @john
    visit admin_profile_url
    assert_selector 'h1', text: 'Dashboard - My Profile'

    @query = 'jeff'
    fill_in 'Search', with: "#{@query}\n"

    # input = find_field 'Search'
    # input.send_keys 'jeff', :enter

    @contacts = @john.contacts.where('first_name like ? or last_name like ?', "%#{@query}%", "%#{@query}%")
    assert_selector 'h1', text: 'Dashboard - Search'
    assert_text 'Jeff', count: 1
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class NotesSystemTest < ApplicationSystemTestCase
  setup do
    @mike = users(:mike)
  end

  test 'visiting the admin profile show the notes' do
    sign_in @mike
    visit admin_profile_url
    assert_selector 'p', text: 'This is Mike second note for Mike'
  end

  test 'create a Note' do
    sign_in @mike
    visit admin_profile_url

    page.fill_in 'note_content', with: 'I am adding this note'
    click_on 'Add Note'

    assert_text 'Your Note was successfully created.'
    assert_selector 'p', text: 'I am adding this note'
  end

  test 'delete a Note' do
    sign_in @mike
    visit admin_profile_url

    accept_alert do
      click_button 'delete_note_button', match: :first
    end

    assert_text 'Your Note was successfully deleted.'
    assert_selector 'p', text: 'This is a note for Mike', count: 0
    assert_selector 'p', text: 'This is Mike second note for Mike'
  end
end

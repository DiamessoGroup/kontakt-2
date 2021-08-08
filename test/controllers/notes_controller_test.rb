# frozen_string_literal: true

require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @mike = users(:mike)
    @mike_note = notes(:mike_note)
  end

  test 'should create note when logged in' do
    sign_in @mike
    assert_difference 'Note.count' do
      post user_notes_path(@mike), params: { note: { content: 'This is a new note' } }
    end

    assert_redirected_to admin_profile_path
    # Ensures that expected == actual is true.
    assert_equal('This is a new note', @mike.notes.last.content)
  end

  test 'should redirect to login when trying create note and not logged in' do
    assert_no_difference 'Note.count' do
      post user_notes_path(@mike), params: { note: { content: 'This is a new note' } }
    end

    assert_redirected_to new_user_session_path
    # Ensures that expected == actual is true.
    assert_not_equal('This is a new note', @mike.notes.last.content)
  end

  test 'should delete note successfully when logged in' do
    sign_in @mike
    assert_difference 'Note.count', -1 do
      delete user_note_path(@mike, @mike_note)
    end

    assert_redirected_to admin_profile_path
  end

  test 'should not delete note successfully when not logged in' do
    assert_no_difference 'Note.count' do
      delete user_note_path(@mike, @mike_note)
    end

    assert_redirected_to new_user_session_path
  end
end

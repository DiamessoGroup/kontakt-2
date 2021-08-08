# frozen_string_literal: true

require 'test_helper'

class NoteIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @mike = users(:mike)
    @mike_note = notes(:mike_note)
  end

  test 'should create note when logged in' do
    sign_in @mike
    assert_difference 'Note.count' do
      post user_notes_url(@mike), params: { note: { content: 'This is a new note' } }
    end
    assert_equal 'Your Note was successfully created.', flash[:success]

    assert_response :redirect
    assert_equal 'create', @controller.action_name

    follow_redirect!
    assert_select 'p', text: 'This is a new note'
    assert_select 'p', text: 'This is a note for Mike'
  end

  test 'should delete note when logged in' do
    sign_in @mike
    assert_difference 'Note.count', -1 do
      delete user_note_url(@mike, @mike_note)
    end
    assert_equal 'Your Note was successfully deleted.', flash[:success]

    assert_response :redirect
    assert_equal 'destroy', @controller.action_name

    follow_redirect!
    assert_select 'p', text: 'This is Mike second note for Mike'
    assert_select 'p', text: 'This is a note for Mike', count: 0
  end
end

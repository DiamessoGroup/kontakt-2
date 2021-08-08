# frozen_string_literal: true

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  def setup
    @mike = users(:mike)
  end

  test 'empty note should not be valid' do
    @note = @mike.notes.build(content: '')
    assert_not @note.valid?
  end

  test 'note should be valid when note content present' do
    @note = @mike.notes.build(content: 'Here is a note')
    assert @note.valid?
  end
end

# frozen_string_literal: true

module ContactsHelper
  def is_favorite?(boolean)
    boolean ? '&#10004;	'.html_safe : ''
  end
end

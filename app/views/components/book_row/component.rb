# frozen_string_literal: true

class BookRow::Component < ApplicationViewComponent
  option :book

  def user_actions
    if helpers.current_user
      if helpers.current_user.admin?
        link_to "Edit", edit_admin_book_path(book)
      else
        link_to "Subscribe", book_path(book)
      end
    end
  end
end

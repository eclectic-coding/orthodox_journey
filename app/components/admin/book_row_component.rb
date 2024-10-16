# frozen_string_literal: true

class Admin::BookRowComponent < ApplicationComponent
  option :book

  def user_actions
    if helpers.current_user
      if helpers.current_user.admin?
        link_to "Edit", edit_admin_book_path(book)
      else
        link_to "Subscribe", book_subscriptions_path(book), data: { turbo_method: :post }
      end
    end
  end
end

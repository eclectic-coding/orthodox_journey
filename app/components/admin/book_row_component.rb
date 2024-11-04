# frozen_string_literal: true

class Admin::BookRowComponent < ApplicationComponent
  option :book

  def user_actions
    if helpers.current_user
      if helpers.current_user.admin? && !book.has_subscriptions?
          content_tag(:span, button_to("Delete", admin_book_path(book),
                                       method: :delete,
                                       data: { turbo_confirm: "Are you sure?" }, class: "text-red-500"))
      end
    else
      link_to "Subscribe", book_subscriptions_path(book), data: { turbo_method: :post }
    end
  end
end

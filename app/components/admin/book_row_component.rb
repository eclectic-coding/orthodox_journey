# frozen_string_literal: true

class Admin::BookRowComponent < ApplicationComponent
  option :book

  def user_actions
    if helpers.current_user
      if helpers.current_user.admin?
        content_tag(:div, class: "flex") do
          safe_join([
                      content_tag(:span, link_to("Edit", edit_admin_book_path(book), class: "mr-2")),
                      archive_or_destroy
                    ])
        end
      end
    else
      link_to "Subscribe", book_subscriptions_path(book), data: { turbo_method: :post }
    end
  end

  def archive_or_destroy
    if book.has_subscriptions?
      content_tag(:span, "Archive")
    else
      content_tag(:span, button_to("Delete", admin_book_path(book),
                                   method: :delete,
                                   data: { turbo_confirm: "Are you sure?" }, class: "text-red-500"))
    end
  end
end

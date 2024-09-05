# frozen_string_literal: true

class PageTitle::Component < ApplicationViewComponent
  with_collection_parameter :page_title
  option :title
end

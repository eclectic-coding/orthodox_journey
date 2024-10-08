# app/services/get_book_description.rb
require 'nokogiri'
require 'open-uri'

class BookMetadata
  attr_reader :doc

  def self.retrieve_from(url)
    new(URI.open(url))
  rescue
    new(nil)
  end

  def initialize(html = nil)
    @doc = Nokogiri::HTML(html)
  end

  def attributes
    { description: get_description }
  end

  def get_description
    @doc.at_css('div.mw-content-ltr.mw-parser-output')
    first_paragraph = @doc.css('p').find { |p| p['class'].nil? }
    first_paragraph ? first_paragraph.inner_text.gsub(/\[\d+\]/, '') : nil
  end

  def image
    nil
  end
end

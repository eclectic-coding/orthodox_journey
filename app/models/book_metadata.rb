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
    { description: get_description, image: get_image }
  end

  def get_description
    @doc.at_css('div.mw-content-ltr.mw-parser-output')
    first_paragraph = @doc.css('p').find { |p| p['class'].nil? }
    first_paragraph ? first_paragraph.inner_text.gsub(/\[\d+\]/, '') : nil
  end

  def get_image
    meta_tag_content('og:image', name_attribute: :property)
  end

  def meta_tag_content(name, name_attribute: :name)
    doc.at_css("meta[#{name_attribute}='#{name}']")&.attributes&.fetch("content", nil)&.text
  end
end

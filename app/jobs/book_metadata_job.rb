# app/jobs/book_metadata_job.rb
class BookMetadataJob < ApplicationJob
  require 'open-uri'

  def perform(book_id)
    book = Book.find(book_id)
    metadata = BookMetadata.retrieve_from(book.wiki_url).attributes
    book.update!(description: metadata[:description])

    if metadata[:image]
      downloaded_image = URI.open(metadata[:image])
      book.image.attach(io: downloaded_image, filename: "book_#{book.id}.jpg")
    end
  end
end

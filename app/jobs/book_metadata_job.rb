# app/jobs/book_metadata_job.rb
class BookMetadataJob < ApplicationJob
  def perform(book_id)
    book = Book.find(book_id)
    metadata = BookMetadata.retrieve_from(book.wiki_url).attributes
    book.update!(metadata)
  end
end

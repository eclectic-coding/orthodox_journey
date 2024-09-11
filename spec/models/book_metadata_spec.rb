# spec/jobs/book_metadata_job_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe BookMetadataJob, type: :job do
  include ActiveJob::TestHelper

  let(:book) { create(:book) }
  let(:url) { 'https://en.wikipedia.org/wiki/Test_Book' }
  let(:html_response) do
    <<-HTML
    <html>
      <body>
        <div class="mw-content-ltr mw-parser-output">
          <p>This is a test book description.</p>
        </div>
        <meta property="og:image" content="https://example.com/test_image.jpg" />
      </body>
    </html>
    HTML
  end

  before do
    stub_request(:get, url).to_return(body: html_response, status: 200)
    stub_request(:get, "https://example.com/test_image.jpg").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: File.new(Rails.root.join('spec/fixtures/files/test_image.jpg')), headers: {})
    allow(BookMetadata).to receive(:retrieve_from).and_return(BookMetadata.new(html_response))
  end

  it 'attaches the image to the book' do
    perform_enqueued_jobs do
      BookMetadataJob.perform_later(book.id)
    end

    book.reload
    expect(book.image).to be_attached
  end
end

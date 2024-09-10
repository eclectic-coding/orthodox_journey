# spec/models/book_metadata_spec.rb

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe BookMetadata, type: :model do
  describe '.retrieve_from' do
    let(:url) { 'https://en.wikipedia.org/wiki/Test_Book' }
    let(:html_response) do
      <<-HTML
      <html>
        <body>
          <div class="mw-content-ltr mw-parser-output">
            <p>This is a test book description.</p>
          </div>
        </body>
      </html>
      HTML
    end

    before do
      stub_request(:get, url).to_return(body: html_response, status: 200)
    end

    it 'retrieves the book description from the given URL' do
      metadata = BookMetadata.retrieve_from(url)
      expect(metadata.attributes[:description]).to eq('This is a test book description.')
    end

    context 'when the request fails' do
      before do
        stub_request(:get, url).to_return(status: 404)
      end

      it 'handles the error gracefully' do
        expect { BookMetadata.retrieve_from(url) }.not_to raise_error
      end
    end
  end
end

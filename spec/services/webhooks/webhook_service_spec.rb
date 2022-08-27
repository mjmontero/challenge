require 'rails_helper'

RSpec.describe Webhooks::WebhookService do
  let(:tag) { create(:tag) }
  let(:stub_webhook_request) {
    stub_request(:post, WEBHOOKSITE_URL).
        with(
          body: tag.to_json(:only => [ :tag_name, :count ]),
        ).
        to_return(status: 200, body: "", headers: {})
    }

  before(:each) do
    stub_webhook_request
  end

  describe '#send_request' do
    it 'sends a webhook request' do
      expect(Webhooks::WebhookService.send_request(WEBHOOKSITE_URL, tag.to_json(:only => [ :tag_name, :count ]))).to eq 200
    end
  end
end
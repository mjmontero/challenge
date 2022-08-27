require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { build(:tag) }
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

  describe "after_save" do
    it "sends webhook" do
      expect(Webhooks::WebhookService).to receive(:send_request).with(WEBHOOKSITE_URL, tag.to_json(:only => [ :tag_name, :count ]))
      tag.save
    end
  end
end

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { create(:ticket) }
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

  describe "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:tags).is_at_most(5).with_message("A ticket can only have a maximum of 5 tags") }
  end

  describe "#set_rececived_at" do
    it "sets received_at field" do
      expect(ticket.received_at).to be_present
    end
  end

  describe "#create_tags" do
    context "tag already exists" do
      it "increments count" do
        Tag.create(tag_name: "one", count: 1)
        ticket_with_tags = Ticket.create(user_id: 1, title: "test", tags: ["One"])
        tag = Tag.where(tag_name: "one").first
        expect(tag.count).to eq 2
      end
    end

    context "tag does not exist" do
      it "creates case insensitive tag" do
        ticket_with_tags = Ticket.create(user_id: 1, title: "test", tags: ["TWO"])
        tag = Tag.where(tag_name: "two").first
        expect(tag.count).to eq 1
      end
    end

    context "no tags present" do
      it "creates ticket without tags" do
        ticket_without_tags = Ticket.new(user_id: 1, title: "test")
        expect(ticket_without_tags.save).to be true
        expect(ticket_without_tags.tags).to be nil
      end
    end
  end
end

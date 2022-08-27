require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  let(:tag) { create(:tag) }
  let(:stub_webhook_request) {
    stub_request(:post, WEBHOOKSITE_URL).
        with(
          body: tag.to_json(:only => [ :tag_name, :count ]),
        ).
        to_return(status: 200, body: "", headers: {})
    }
  let(:valid_ticket_params) {
    {
      user_id: 1,
      title: "test",
      tags: ["Hello", "Bye"],
      format: :json
    }
  }

  let(:invalid_ticket_params) {
    {
      tags: ["Hello", "Bye", "three", "four", "five", "six"],
      format: :json
    }
  }

  before(:each) do
    stub_webhook_request
  end

  describe "POST /create" do
    context "with valid params" do
      it "creates a new ticket" do
        expect {
          post "/api/v1/tickets", params: valid_ticket_params
        }.to change(Ticket, :count).by(1)
      end
    end

    context "with invalid params" do
      it "does not create ticket" do
        expect {
          post "/api/v1/tickets", params: invalid_ticket_params
        }.not_to change { Ticket.count }
      end

      it "returns 422" do
        post "/api/v1/tickets", params: invalid_ticket_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns user_id can't be blank error message" do
        post "/api/v1/tickets", params: invalid_ticket_params
        expect(JSON.parse(response.body)["user_id"][0]).to eq("can't be blank")
      end

      it "returns title can't be blank error message" do
        post "/api/v1/tickets", params: invalid_ticket_params
        expect(JSON.parse(response.body)["title"][0]).to eq("can't be blank")
      end      

      it "returns tags max length error message" do
        post "/api/v1/tickets", params: invalid_ticket_params
        expect(JSON.parse(response.body)["tags"][0]).to eq("A ticket can only have a maximum of 5 tags")
      end      
    end

  end
end

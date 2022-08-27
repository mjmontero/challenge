class Tag < ApplicationRecord
  after_save :send_webhook

  def send_webhook
    tag = Tag.select("tag_name, Max(count) as count").group(:id).first
    Webhooks::WebhookService.send_request(WEBHOOKSITE_URL, tag.to_json(:only => [ :tag_name, :count ]))
  end
end
  
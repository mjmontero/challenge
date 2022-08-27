class Webhooks::WebhookService

  def self.send_request(url, body)

    response = RestClient.post(
      url,
      body,
      content_type: :json,
      accept: :json,
      timeout: 100
    )

    return response.code
  end

end

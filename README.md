# README

This is a simple app to call an endpoint that creates tickets and its tags.

## Prerequisites

* Ruby version: 3.0.2
* MySQL 
* Bundler 2.3.6


## Deployment instructions
1. Pull the code into a local folder
2. cd challenge
3. bundle install
4. Make sure MySQL is running
5. rake db:create 
6. rake db:migrate
7. run the server on port 3000 with ```rails s```

## How to use it
### Option 1
1. Open postman
2. Send the following request:
* POST http://localhost:3000/api/v1/tickets
* Payload: 
```json
{
    "user_id": 1,
    "title": "test",
    "tags": ["1", "2", "3"]
}
```

### Option 2
1. Use CURL - copy and paste the following code snippet into a terminal

```
curl --location --request POST 'http://localhost:3000/api/v1/tickets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user_id": 1,
    "title": "test",
    "tags": ["1", "2", "3"]
}'
```
## Testing the webhook
1. Go to https://webhook.site/
2. Copy your unique URL
3. Paste the value in WEBHOOK_URL in config/initializers/my_constants.rb
4. Restart the server
5. Create a new ticket with a [POST request](#How-to-use-it)
6. Look how the request is sent to Webhook.site

## How to run the test suite

```bundle exec rspec```


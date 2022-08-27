# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.0.2

* System dependencies

* Configuration

* Database creation
db:create
db:migrate

* Database initialization

* How to run the test suite
bundle exec rspec

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
1. Pull the code into a local folder
2. cd challenge
3. bundle install
4. db:create
5. db:migrate
6. run the server on port 3000 with ´rails s´

* How to use it
** Option 1
1. Open postman
2. Send the following request: 
Request: POST http://localhost:3000/api/v1/tickets 
Payload: 
{
    "user_id": 1,
    "title": "test3",
    "tags": ["1", "2", "3"]
}
** Option 2
1. Use CURL

* Testing the webhook
1. Go to https://webhook.site/
2. Copy your unique URL
3. Paste the value in WEBHOOK_URL in config/initializers/my_constants.rb
4. Follow the steps on "How to use it"
5. Look how the request is sent to Webhook.site



* ...

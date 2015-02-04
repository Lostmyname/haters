require 'bundler'
require 'pp'
Bundler.require

# Load config from `.env`
Dotenv.load

# Configure Delighted
Delighted.api_key = ENV['DELIGHTED_API_KEY']

# Connect to Redis
redis = Redis.new(url: ENV['REDIS_URL'])

# Collect last detractor timestamp from Redis; if it's nil, use current time
last_detractor_timestamp = redis.get('last_detractor_timestamp') || 0
new_detractor_timestamp  = nil

# Gather survey responses from Delighted
Delighted::SurveyResponse.all(
  trend: ENV['DELIGHTED_TREND_ID'],
  order: 'desc',
  since: last_detractor_timestamp,
  expand: ['person']
).each do |response|
  new_detractor_timestamp ||= response.created_at

  HTTParty.post(
    ENV['SLACK_WEBHOOK_ENDPOINT'],
    body: {
      text: "*#{response.person.email}*: #{response.comment} <#{response.permalink}|(View Comment)>"
    }.to_json,
    options: {
      headers: {
        'Content-Type' => 'application/json'
      }
    }
  )
end

redis.set('last_detractor_timestamp', new_detractor_timestamp + 1) if new_detractor_timestamp

# Shake It Off
This is an application which pulls detractors from [Delighted](https://delighted.com/),
our [NPS](http://en.wikipedia.org/wiki/Net_Promoter) tracking system and posts
them into a room on Slack.

This allows us to easily get an overview of what's causing people to be unhappy
with our product, and discuss it from within our company chat infrastructure.

It's called *Shake It Off* because of a wonderful line from Taylor Swift in said
song, specifically around the "haters" that are going to "hate hate hate hate hate".
Shakespearian, that.

## Dependencies
- Ruby 2.2.0
- Redis

## Usage
1. Copy `.env.sample` to `.env` and fill in the blanks
2. Run `bundle install`
3. Run `ruby haters.rb` and the most recent detractor comments will show up in Slack

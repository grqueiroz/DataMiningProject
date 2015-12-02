require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'ap'
require 'colorize'
Bundler.require

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key    = "8RpFIQIVraqgK4KaGL9rPJeQK"
  config.consumer_secret = "7L6uiP0kDwz3mAdlJ3BKqWarBR0yJc5PDM925nYCCwEvr0yvAp"
  config.access_token = "110405261-gRcWqaMQTBtafqztD8jN7TZbFcDHqffjnn0x7QPR"
  config.access_token_secret = "DOhrehBsBckOhKDorMyBWZTGpAIPyUr6odZPlrx4G6kxN"
end

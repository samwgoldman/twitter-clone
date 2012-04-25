require "capybara/cucumber"
require "webmachine/adapter"
require "webmachine/adapters/rack"

require_relative "../../app"

Capybara.app = Webmachine::Adapters::Rack.new(App.configuration, App.dispatcher)

require "./app"
require "webmachine/adapters/rack"

run Webmachine::Adapters::Rack.new(App.configuration, App.dispatcher)

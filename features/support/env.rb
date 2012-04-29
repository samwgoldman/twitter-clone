require_relative "../../app"
require "capybara/cucumber"
require "capybara/webkit"
require "webmachine/adapters/rack"

Capybara.app = Webmachine::Adapters::Rack.new(App.configuration, App.dispatcher)

Capybara.current_driver = Capybara.javascript_driver = :webkit

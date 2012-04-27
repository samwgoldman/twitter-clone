require_relative "../../app"
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"
require "capybara"
require "webmachine/adapters/rack"

RspecApiDocumentation.configure do |config|
  config.app = Webmachine::Adapters::Rack.new(App.configuration, App.dispatcher)
end

module HtmlHelpers
  def html_response
    Capybara::Node::Simple.new(response_body)
  end
end

RSpec.configure do |config|
  config.include HtmlHelpers
end

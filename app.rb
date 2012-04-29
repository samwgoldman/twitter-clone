$LOAD_PATH << File.expand_path("../resources", __FILE__)
$LOAD_PATH << File.expand_path("../models", __FILE__)
$LOAD_PATH << File.expand_path("../lib", __FILE__)

require "webmachine"
require "webmachine/adapters/rack"

require "home_resource"
require "javascript_resource"
require "messages_resource"
require "message_resource"

App = Webmachine::Application.new do |app|
  app.routes do
    add [], HomeResource
    add ["application.js"], JavascriptResource
    add ["messages"], MessagesResource
    add ["messages", :id], MessageResource
  end
end

App.configure do |config|
  config.port = ENV["PORT"] || 8080
  config.adapter = :Rack
  config.adapter_options = { :server => "mongrel" }
end

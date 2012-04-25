$LOAD_PATH << File.expand_path("../resources", __FILE__)
$LOAD_PATH << File.expand_path("../models", __FILE__)

require "webmachine"
require "haml"
require "securerandom"

require "home_resource"
require "messages_resource"

App = Webmachine::Application.new do |app|
  app.routes do
    add [], HomeResource
    add ["messages"], MessagesResource
  end
end

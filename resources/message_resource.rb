require "message"
require "haml"

class MessageResource < Webmachine::Resource
  def content_types_provided
    [["application/xhtml+xml", :to_xhtml]]
  end

  private

  def template
    File.read(File.expand_path("../../views/message.haml", __FILE__))
  end

  def view
    Haml::Engine.new(template)
  end

  def to_xhtml
    message = Message.find(request.path_info[:id])
    view.render(message)
  end
end

require "message"
require "haml"
require "uri"
require "id"

class MessagesResource < Webmachine::Resource
  def allowed_methods
    ["GET", "POST"]
  end

  def content_types_accepted
    [["application/x-www-form-urlencoded", :from_form]]
  end

  def content_types_provided
    [["application/xhtml+xml", :to_xhtml]]
  end

  def post_is_create?
    true
  end

  def create_path
    @id = ID.generate
    "/messages/#@id"
  end

  private

  def to_xhtml
    messages = Message.all
    view.render(messages)
  end

  def from_form
    message = Message.new(params["message"])
    message.save(@id)
    response.do_redirect
  end

  def params
    Hash[URI.decode_www_form(request.body.to_s)]
  end

  def template
    File.read(File.expand_path("../../views/messages.haml", __FILE__))
  end

  def view
    Haml::Engine.new(template)
  end
end

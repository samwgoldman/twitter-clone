require "message"
require "uri"
require "id"

class MessagesResource < HamlResource
  def allowed_methods
    ["GET", "POST"]
  end

  def content_types_accepted
    [["application/x-www-form-urlencoded", :from_form]]
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
end

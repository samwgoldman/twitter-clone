require "message"
require "uri"

class MessagesResource < Webmachine::Resource
  def allowed_methods
    ["POST"]
  end

  def content_types_accepted
    [["application/x-www-form-urlencoded", :from_form]]
  end

  def post_is_create?
    true
  end

  def allow_missing_post?
    true
  end

  def resource_exists?
    false
  end

  def create_path
    "/"
  end

  private

  def params
    Hash[URI.decode_www_form(request.body.to_s)]
  end

  def from_form
    message = Message.new(params["message"])
    id = SecureRandom.hex(20)
    message.save(id)
    response.do_redirect
  end
end

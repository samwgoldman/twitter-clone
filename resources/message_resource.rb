require "message"

class MessageResource < HamlResource
  private

  def to_xhtml
    message = Message.find(request.path_info[:id])
    view("message").render(message)
  end
end

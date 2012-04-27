require "message"
require "haml"

class HomeResource < Webmachine::Resource
  private

  def template
    File.read(File.expand_path("../../views/home.haml", __FILE__))
  end

  def view
    Haml::Engine.new(template)
  end

  def to_html
    messages = Message.all
    view.render(binding)
  end
end

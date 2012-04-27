require "message"
require "haml"

class HomeResource < Webmachine::Resource
  def content_types_provided
    [["text/html", :to_xhtml], ["application/xhtml+xml", :to_xhtml]]
  end

  private

  def template
    File.read(File.expand_path("../../views/home.haml", __FILE__))
  end

  def view
    Haml::Engine.new(template)
  end

  def to_xhtml
    view.render
  end
end

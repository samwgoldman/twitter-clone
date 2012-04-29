require "haml"

class HamlResource < Webmachine::Resource
  def content_types_provided
    [["text/html", :to_xhtml], ["application/xhtml+xml", :to_xhtml]]
  end

  private

  def template_path
    views_dir = File.expand_path("../../views", __FILE__)
    if request.path_tokens.empty?
      File.join(views_dir, "home.haml")
    else
      File.join(views_dir, *request.path_tokens, ".haml")
    end
  end

  def template
    File.read(template_path)
  end

  def view
    Haml::Engine.new(template)
  end

  def to_xhtml
    view.render
  end
end

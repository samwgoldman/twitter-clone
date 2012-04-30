require "haml"

class HamlResource < Webmachine::Resource
  def content_types_provided
    [["text/html", :to_xhtml], ["application/xhtml+xml", :to_xhtml]]
  end

  private

  def views_dir
    File.expand_path("../../views", __FILE__)
  end

  def template_path(path = request.disp_path)
    if path.empty?
      File.join(views_dir, "home.haml")
    else
      File.join(views_dir, "#{path}.haml")
    end
  end

  def template(path = request.disp_path)
    File.read(template_path(path))
  end

  def view(path = request.disp_path)
    Haml::Engine.new(template(path))
  end

  def to_xhtml
    view.render
  end
end

require "coffee_script"

class JavascriptResource < Webmachine::Resource
  def content_types_provided
    [["application/javascript", :to_javascript]]
  end

  private

  def to_javascript
    base_dir = File.expand_path("../../coffee", __FILE__)
    scripts = File.join(base_dir, "**", "*.coffee")
    Dir[scripts].inject("") do |js, script|
      js << CoffeeScript.compile(File.read(script))
    end
  end
end

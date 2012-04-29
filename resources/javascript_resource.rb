require "coffee_script"
require "uglifier"

class JavascriptResource < Webmachine::Resource
  def content_types_provided
    [["application/javascript", :to_javascript]]
  end

  def last_modified
    scripts.map { |script| File.mtime(script) }.max
  end

  private

  def self.scripts
    @scripts ||= []
  end

  def self.add_path(type)
    base_dir = File.expand_path("../../#{type}", __FILE__)
    scripts = Dir[File.join(base_dir, "**", "*.#{type}")]
    self.scripts.concat(scripts)
    define_method(type) { scripts }
  end

  def scripts
    self.class.scripts
  end

  add_path :coffee
  add_path :js

  def to_javascript
    combined = ""
    js.each do |script|
      combined << File.read(script)
    end
    coffee.each do |script|
      combined << CoffeeScript.compile(File.read(script))
    end
    Uglifier.compile(combined)
  end
end

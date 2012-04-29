require "coffee_script"
require "uglifier"
require "assets"

class JavascriptResource < Webmachine::Resource
  def content_types_provided
    [["application/javascript", :to_javascript]]
  end

  def last_modified
    self.class.scripts.map { |script| File.mtime(script) }.max
  end

  private

  def self.scripts
    @scripts ||= Assets.new
  end

  scripts.add_assets "js", "*jquery*.js"
  scripts.add_assets "js"
  scripts.add_assets "coffee"

  def to_javascript
    combined = ""
    self.class.scripts.each do |script|
      if script =~ /coffee$/
        combined << CoffeeScript.compile(File.read(script))
      else
        combined << File.read(script)
      end
    end
    Uglifier.compile(combined)
  end
end

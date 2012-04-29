require "coffee_script"
require "uglifier"
require "assets"

class JavascriptResource < Webmachine::Resource
  def self.scripts
    @scripts ||= Assets.new
  end

  def self.compile
    if @last_compiled && @last_compiled < scripts.last_modified
      @compiled = nil
    end
    @compiled ||= begin
      @last_compiled = Time.now
      combined = ""
      scripts.each do |script|
        if script =~ /coffee$/
          combined << CoffeeScript.compile(File.read(script))
        else
          combined << File.read(script)
        end
      end
      Uglifier.compile(combined)
    end
  end

  scripts.add_assets "js", "*jquery*.js"
  scripts.add_assets "js"
  scripts.add_assets "coffee"
  compile

  def content_types_provided
    [["application/javascript", :to_javascript]]
  end

  def last_modified
    self.class.scripts.last_modified
  end

  private

  def to_javascript
    self.class.compile
  end
end

require "coffee_script"

class JavascriptResource < Webmachine::Resource
  def content_types_provided
    [["application/javascript", :to_javascript]]
  end

  def last_modified
    scripts.inject(Time.at(0)) do |mtime, script|
      [mtime, File.mtime(script)].max
    end
  end

  def generate_etag
    last_modified.to_i.to_s
  end

  private

  def scripts
    base_dir = File.expand_path("../../coffee", __FILE__)
    Dir[File.join(base_dir, "**", "*.coffee")]
  end

  def to_javascript
    Struct.new(:scripts) do
      include Enumerable
      def each(&block)
        scripts.each do |script|
          yield CoffeeScript.compile(File.read(script))
        end
      end
    end.new(scripts)
  end
end

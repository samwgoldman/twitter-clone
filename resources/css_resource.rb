require "less"
require "assets"

class CssResource < Webmachine::Resource
  def self.styles
    @styles ||= Assets.new
  end

  def self.compile
    if @last_compiled && @last_compiled < styles.last_modified
      @compiled = nil
    end
    @compiled ||= begin
      @last_compiled = Time.now
      parser = Less::Parser.new(:paths => styles.paths)
      combined = ""
      styles.each do |style|
        combined << File.read(style)
      end
      parser.parse(combined).to_css(:compress => true)
    end
  end

  styles.add_path "less/bootstrap"
  styles.add_asset "less", "application.less"
  compile

  def content_types_provided
    [["text/css", :to_css]]
  end

  def last_modified
    self.class.styles.last_modified
  end

  private

  def to_css
    self.class.compile
  end
end

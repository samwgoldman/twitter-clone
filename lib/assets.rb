class Assets
  include Enumerable

  def initialize(base_dir = ".")
    @base_dir = base_dir
    @assets = []
  end

  def add_assets(dir, pattern = "*")
    files = Dir[File.join(@base_dir, dir, "**", pattern)]
    @assets.concat(files).uniq!
  end
  alias :add_asset :add_assets

  def each(&block)
    @assets.each(&block)
  end
end

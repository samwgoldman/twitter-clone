class Assets
  include Enumerable

  attr_reader :paths

  def initialize(base_dir = ".")
    @base_dir = base_dir
    @assets = []
    @paths = []
  end

  def add_assets(dir, pattern = ["**", "*"])
    @paths.concat(Dir[dir])
    files = Dir[File.join(@base_dir, dir, *pattern)].each do |path|
      if File.directory?(path)
        @paths << path
      else
        @assets << path
      end
    end
    @paths.uniq!
    @assets.uniq!
  end
  alias :add_asset :add_assets

  def add_path(dir)
    @paths.concat(Dir[dir])
  end

  def each(&block)
    @assets.each(&block)
  end

  def last_modified
    files = @paths.inject([]) do |files, path|
      files.concat(Dir[File.join(path, "**", "*")])
    end
    files.map { |file| File.mtime(file) }.max
  end
end

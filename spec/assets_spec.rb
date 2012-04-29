require_relative "../lib/assets.rb"
require 'fakefs/spec_helpers'

describe Assets do
  include FakeFS::SpecHelpers

  let(:assets) { Assets.new }

  before do
    %w{foo bar}.each do |dir|
      FileUtils.mkdir dir
      %w{a b c}.each do |file|
        FileUtils.touch File.join(dir, file)
      end
    end
  end

  it "enumerates assets in the order added" do
    assets.add_assets "bar"
    assets.add_assets "foo"
    assets.to_a.should eq(Dir["bar/*"] + Dir["foo/*"])
  end

  it "doesn't add the same asset twice" do
    assets.add_asset "foo", "b"
    assets.add_assets "foo"
    assets.to_a.should eq(Dir["foo/b"] + Dir["foo/a"] + Dir["foo/c"])
  end

  it "maintains a list of paths" do
    FileUtils.mkdir "foo/baz"
    FileUtils.mkdir "bar/baz"
    assets.add_assets "foo/baz"
    assets.add_assets "foo"
    assets.add_assets "bar"
    assets.paths.should eq(Dir["foo/baz"] + Dir["foo"] + Dir["bar"] + Dir["bar/baz"])
  end

  it "can store paths separate from assets" do
    assets.add_path "foo"
    assets.paths.should eq(Dir["foo"])
  end

  it "does not include directories in the assets" do
    FileUtils.mkdir "foo/baz"
    assets.add_assets "foo"
    assets.to_a.should eq(Dir["foo/a"] + Dir["foo/b"] + Dir["foo/c"])
  end
end

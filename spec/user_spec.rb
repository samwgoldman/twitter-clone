require_relative "../models/user"

describe User do
  before do
    BCrypt::Password.stub!(:create) do |password|
      "crypted " + password
    end
  end

  it "is created with a username and password" do
    user = User.new("username", "password")
    user.username.should eq("username")
    user.password.should eq("crypted password")
  end

  it "can retrieve persisted users by username" do
    user = User.new("username", "password")
    user.save
    User.find("username").should eq(user)
  end
end

require "bcrypt"

class User
  class << self
    attr_accessor :default_cost
  end
  self.default_cost = 8

  attr_reader :username, :password

  DB = {}

  def self.find(username)
    DB[username]
  end

  def initialize(username, password)
    @username = username
    @password = BCrypt::Password.create(password, :cost => User.default_cost)
  end

  def save
    DB[username] = self
  end
end

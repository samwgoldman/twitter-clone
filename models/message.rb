class Message
  attr_reader :id, :body

  DB = {}

  def self.find(id)
    DB[id]
  end

  def self.all
    DB.values
  end

  def initialize(body)
    @body = body
  end

  def save(id)
    @id = id
    DB[@id] = self
  end

  def ==(other)
    self.id == other.id
  end
end

require_relative "../models/message"

describe Message do
  before { Message::DB.clear }

  it "is created with a message body" do
    message = Message.new("Hello, World!")
    message.body.should eq("Hello, World!")
  end

  it "remembers its id when persisted" do
    message = Message.new("Hello, World!")
    message.save("id")
    message.id.should eq("id")
  end

  it "considers messages with the same id to be equal (==)" do
    a = Message.new("a").save("id")
    b = Message.new("b").save("id")
    a.should eq(b)
  end

  it "can retrieve persisted messages by id" do
    Message.new("Hello, World!").save("id")
    message = Message.find("id")
    message.body.should eq("Hello, World!")
  end

  it "can retrieve all persisted messages" do
    messages = begin
                 a = Message.new("a")
                 b = Message.new("b")
                 a.save(1)
                 b.save(2)
                 [a, b]
               end
    Message.all.should =~ messages
  end
end

require_relative "./spec_helper"

resource "Messages" do
  get "/messages" do
    before do
      Message.new("One").save(1)
      Message.new("Two").save(2)
    end

    example_request "Retrieving all messages" do
      status.should eq(200)
      html_response.all("#content > li").map(&:text).should eq(["One", "Two"])
    end
  end

  post "/messages" do
    parameter :message, "The content of the message"

    let(:message) { "Hello, World!" }

    before { Message::DB.clear }

    example_request "Posting a message" do
      status.should eq(303)
      client.get response_headers["Location"]
      status.should eq(200)
      html_response.find("#content").text.should eq("Hello, World!")
    end
  end
end

require_relative "./spec_helper"

resource "Assets" do
  get "/application.js" do
    example_request "Application javascript" do
      status.should eq(200)
      response_headers["Content-Type"].should eq("application/javascript")
    end
  end

  get "/application.css" do
    example_request "Application CSS" do
      status.should eq(200)
      response_headers["Content-Type"].should eq("text/css")
    end
  end
end

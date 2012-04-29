require_relative "./spec_helper"

resource "JS", :document => false do
  get "/application.js" do
    example_request "Downloading the JS" do
      status.should eq(200)
      response_headers["Content-Type"].should eq("application/javascript")
    end
  end
end

resource "CSS", :document => false do
  get "/application.css" do
    example_request "Downloading the CSS" do
      status.should eq(200)
      response_headers["Content-Type"].should eq("text/css")
    end
  end
end

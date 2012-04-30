require_relative "./spec_helper"
require "base64"

resource "Authentication" do
  before do
    User.new("username", "password").save
  end

  get "/sign_in" do
    example_request "Requesting sign in without credentials" do
      status.should eq(200)
      form = html_response.find("form")
      form["action"].should eq("/sign_in")
      form["method"].should eq("GET")
    end

    context "with correct credentials" do
      let(:client) do
        authorization = "Basic #{Base64.strict_encode64("username:password")}"
        headers = { "HTTP_AUTHORIZATION" => authorization }
        RspecApiDocumentation::RackTestClient.new(self, :headers => headers)
      end

      example_request "Requesting sign in with correct credentials" do
        status.should eq(200)
        html_response.find("#content").text.should eq("Signed in as username.")
      end
    end

    context "with invalid credentials" do
      let(:client) do
        authorization = "Basic #{Base64.strict_encode64("username:bad")}"
        headers = { "HTTP_AUTHORIZATION" => authorization }
        RspecApiDocumentation::RackTestClient.new(self, :headers => headers)
      end

      example_request "Requesting sign in with correct credentials" do
        status.should eq(200)
        form = html_response.find("form")
        form["action"].should eq("/sign_in")
        form["method"].should eq("GET")
      end
    end
  end
end

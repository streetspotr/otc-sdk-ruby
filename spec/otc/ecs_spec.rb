require "spec_helper"

RSpec.describe Otc::ECS do
  before(:each) do
    Otc::Configuration.configure do |config|
      config.username = "dev"
      config.password = "test1234"
      config.domainname = "OTC-0001"
      config.region = "eu-de"
      config.project = "12343123"
    end

    stub_request(:post, "https://iam.eu-de.otc.t-systems.com/v3/auth/tokens").
      to_return(status: 200, headers: { "X-Subject-Token" => "Initial token" })
  end

  describe "::query_all" do
    it "should return an array of ecs" do
      body = load_response("ecs_details")
      stub_request(:get, "https://ecs.eu-de.otc.t-systems.com/v2/12343123/servers/detail?name=").
        to_return(status: 200, body: body)

      ecs = Otc::ECS.query_all

      expect(ecs.first.name).to eq("new-server-test")
    end
  end

  describe "::query_one" do
    it "should return one ecs" do
      body = load_response("ecs_details")
      stub_request(:get, "https://ecs.eu-de.otc.t-systems.com/v2/12343123/servers/detail?name=").
        to_return(status: 200, body: body)

      ecs = Otc::ECS.query_one

      expect(ecs.name).to eq("new-server-test")
    end
  end
end

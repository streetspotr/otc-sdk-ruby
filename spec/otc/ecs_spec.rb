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

  describe "#public_ip" do
    it "should return the public IP address" do
      body = load_response("publicips")
      stub_request(:get, "https://ecs.eu-de.otc.t-systems.com/v1/12343123/publicips").
        to_return(status: 200, body: body)

      ecs = Otc::ECS.new("addresses" => { "1234123" => [{ "addr" => "192.168.10.5" }] })
      expect(ecs.public_ip).to eq("161.17.101.9")
    end

    it "should return nil if no public ip exists" do
      body = load_response("publicips")
      stub_request(:get, "https://ecs.eu-de.otc.t-systems.com/v1/12343123/publicips").
        to_return(status: 200, body: body)

      ecs = Otc::ECS.new("addresses" => { "1234123" => [{ "addr" => "192.168.10.0" }] })
      expect(ecs.public_ip).to be_nil
    end
  end
end

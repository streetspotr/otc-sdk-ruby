require "spec_helper"

RSpec.describe Otc::EIP do
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
    it "should return an array of eips" do
      body = load_response("publicips")
      stub_request(:get, "https://ecs.eu-de.otc.t-systems.com/v1/12343123/publicips")
        .to_return(status: 200, body: body)

      eips = Otc::EIP.query_all

      expect(eips.first.public_ip_address).to eq("161.17.101.9")
      expect(eips[1].public_ip_address).to eq("161.17.101.10")
    end
  end
end

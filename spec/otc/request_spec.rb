require "spec_helper"

RSpec.describe Otc::Request do
  before(:each) do 
    Otc::Request.instance_variable_set(:@_token, nil)

    Otc::Configuration.configure do |config|
      config.region = "eu-de"
      config.username = "dev"
      config.password = "test1234"
      config.domainname = "OTC-001"
      config.project = "12345"
    end
  end

  describe "::base_uri" do
    it "should return the base uri by respecting the given service and path" do
      base_uri = Otc::Request.base_uri service: "iam", path: "/v3/auth/tokens"
      expect(base_uri).to eq("https://iam.eu-de.otc.t-systems.com/v3/auth/tokens")
    end
  end

  describe "::token" do
    it "should return the current token if it is not older than 20 hours" do
      Otc::Request.instance_variable_set(:@_token, {
        token: "123",
        timestamp: (Time.now - (19 * 60 * 60)).to_i # 19 hours ago
      })

      expect(Otc::Request.token).to eq("123")
    end

    it "should obtain a new token if it is older than 20 hours" do
      stub_request(:post, "https://iam.eu-de.otc.t-systems.com/v3/auth/tokens").
        to_return(status: 200, body: "works", headers: { "X-Subject-Token" => "New Token" })


      Otc::Request.instance_variable_set(:@_token, {
        token: "123",
        timestamp: (Time.now - (21 * 60 * 60)).to_i # 21 hours ago
      })

      expect(Otc::Request.token).to eq("New Token")
    end

    it "should initially obtain a new token" do
      stub_request(:post, "https://iam.eu-de.otc.t-systems.com/v3/auth/tokens").
        to_return(status: 200, body: "works", headers: { "X-Subject-Token" => "Initial token" })

      expect(Otc::Request.token).to eq("Initial token")
    end

    it "should raise unauthorized error if request could not be authorized" do
      stub_request(:post, "https://iam.eu-de.otc.t-systems.com/v3/auth/tokens").
        to_return(status: 401)

      expect { Otc::Request.token }.to raise_error(Otc::Request::UnauthorizedError)
    end

    it "should raise an api error if response is something different than 2xx" do
      stub_request(:post, "https://iam.eu-de.otc.t-systems.com/v3/auth/tokens").
        to_return(status: 500)

      expect { Otc::Request.token }.to raise_error(Otc::Request::ApiError)
    end
  end
end

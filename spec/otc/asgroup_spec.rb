require "spec_helper"

RSpec.describe Otc::ASGroup do
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
    it "should return an array of ASGroups" do
      body = load_response("autoscaling_scaling_group")
      stub_request(:get, "https://as.eu-de.otc.t-systems.com/autoscaling-api/v1/12343123/scaling_group?scaling_group_name=").
        to_return(status: 200, body: body)

      as_groups = Otc::ASGroup.query_all

      expect(as_groups.first.scaling_group_name).to eq("first_sg")
      expect(as_groups[1].scaling_group_name).to eq("second_sg")
    end
  end

  describe "::query_one" do
    it "should return only one ASGroup" do
      body = load_response("autoscaling_scaling_group")
      stub_request(:get, "https://as.eu-de.otc.t-systems.com/autoscaling-api/v1/12343123/scaling_group?scaling_group_name=").
        to_return(status: 200, body: body)

      as_group = Otc::ASGroup.query_one
      expect(as_group.scaling_group_name).to eq("first_sg")
    end
  end
end

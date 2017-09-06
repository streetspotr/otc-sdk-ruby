require "spec_helper"

RSpec.describe Otc::Configuration do
  describe "::configure" do
    it "should require a block" do
      expect { Otc::Configuration.configure }.to raise_error(LocalJumpError)
    end

    it "should yield itself" do
      Otc::Configuration.configure do |config|
        expect(config).to be(Otc::Configuration)
      end
    end
  end

  describe "::project" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.project = "cool_project"
      expect(Otc::Configuration.project).to eq("cool_project")
    end
  end

  describe "::username" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.username = "testuser"
      expect(Otc::Configuration.username).to eq("testuser")
    end
  end
  
  describe "::password" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.password = "test1234"
      expect(Otc::Configuration.password).to eq("test1234")
    end
  end

  describe "::region" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.region = "eu-de"
      expect(Otc::Configuration.region).to eq("eu-de")
    end
  end

  describe "::domainname" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.domainname = "OTC-0001"
      expect(Otc::Configuration.domainname).to eq("OTC-0001")
    end
  end
end

require "spec_helper"

RSpec.describe Otc::Configuration do
  before(:each) { Otc::Configuration.reset }

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

    context "!" do
      it "should raise an error if project is nil" do
        expect { Otc::Configuration.project! }.to raise_error(Otc::Configuration::Missing)
      end

      it "should return the project if it is not nil" do
        Otc::Configuration.project = "cool_project"
        expect(Otc::Configuration.project).to eq("cool_project")
      end
    end
  end

  describe "::username" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.username = "testuser"
      expect(Otc::Configuration.username).to eq("testuser")
    end

    context "!" do
      it "should raise an error if username is nil" do
        expect { Otc::Configuration.username! }.to raise_error(Otc::Configuration::Missing)
      end

      it "should return the username if it is not nil" do
        Otc::Configuration.username = "testuser"
        expect(Otc::Configuration.username).to eq("testuser")
      end
    end
  end
  
  describe "::password" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.password = "test1234"
      expect(Otc::Configuration.password).to eq("test1234")
    end

    context "!" do
      it "should raise an error if password is nil" do
        expect { Otc::Configuration.password! }.to raise_error(Otc::Configuration::Missing)
      end

      it "should return the password if it is not nil" do
        Otc::Configuration.password = "test1234"
        expect(Otc::Configuration.password).to eq("test1234")
      end
    end
  end

  describe "::region" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.region = "eu-de"
      expect(Otc::Configuration.region).to eq("eu-de")
    end

    context "!" do
      it "should raise an error if region is nil" do
        expect { Otc::Configuration.region! }.to raise_error(Otc::Configuration::Missing)
      end

      it "should return the region if it is not nil" do
        Otc::Configuration.region = "eu-de"
        expect(Otc::Configuration.region).to eq("eu-de")
      end
    end
  end

  describe "::domainname" do
    it "should have it as an attribute accessor" do
      Otc::Configuration.domainname = "OTC-0001"
      expect(Otc::Configuration.domainname).to eq("OTC-0001")
    end

    context "!" do
      it "should raise an error if domainname is nil" do
        expect { Otc::Configuration.domainname! }.to raise_error(Otc::Configuration::Missing)
      end

      it "should return the domainname if it is not nil" do
        Otc::Configuration.domainname = "OTC-0001"
        expect(Otc::Configuration.domainname).to eq("OTC-0001")
      end
    end
  end
end

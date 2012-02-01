# coding: utf-8
# WARNING: uglifier has 4 dependency gems version at 1.2.3

require 'spec_helper'

def mock_gem
  @gem ||= mock(Gfid::Gem)
end

def mock_web_response
  @response ||= mock(HTTParty::Response)
end

describe Gfid::Manager do
  let :manager do
    Gfid::Manager.instance
  end

  describe "#gem_name(name)" do
    before { manager.gem_name("uglifier") }

    context "instance" do
      subject { manager }
      its(:gems) { should be_instance_of(Array) }
    end

    context "gems" do
      subject { manager.gems }
      its(:size) { should == 1 }
      its(:first) { should be_a_instance_of(Gfid::Gem) }
    end

    context "dependency_gems" do
      subject { manager.dependency_gems }
      its(:size) { should == 2 }
    end

    after do
      manager.clear!
    end
  end

  describe "#collect_gems" do
    before do
      manager.gem_name("uglifier")
      manager.collect_gems
    end

    subject { manager.gems }
    its(:size)  { should == 4 }

    after do
      manager.clear!
    end
  end

  describe "download!" do
    before do
      manager.gem_name("uglifier")
      manager.should_receive(:collect_gems).and_return([mock_gem])
      mock_gem.stub!(:filename).and_return("hoge")
      mock_web_response.should_receive(:body).and_return("hoge")
    end

    it "should receive each Gfid::Gem.download!" do
      mock_gem.should_receive(:download!).and_return(mock_web_response)
      manager.download!
    end

    after do
      FileUtils.rm("hoge")
    end
  end
end

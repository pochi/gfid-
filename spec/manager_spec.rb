# coding: utf-8

require 'spec_helper'

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

  describe "collect_gems" do
    before do
      manager.gem_name("uglifier")
      manager.collect_gems
    end

    subject { manager.gems }
    its(:size)  { should == 4 }

    after do
      puts manager.gems.inspect
    end
  end

end

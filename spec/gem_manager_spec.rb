# coding: utf-8

require 'spec_helper'

describe Gfid::GemManager do
  let :manager do
    Gfid::GemManager.new('uglifier')
  end

  let :manager_with_version do
    Gfid::GemManager.new('youroom_api', :version => '0.1.14')
  end

  describe ".initialize" do
    context "can create instance" do
      it "should be instance of Gfid::GemManager" do
        manager.should be_a_instance_of(Gfid::GemManager)
      end
    end

    describe "can create insance" do
      context "given only gem name" do
        subject { manager }
        its(:name) { should == 'uglifier' }
      end

      context "given gem name and version" do
        subject { manager_with_version }
        its(:name) { should == 'youroom_api' }
        its(:version) { should == '0.1.14' }
      end
    end
  end

  describe "#ask_dependencies" do
    subject { manager.ask_dependencies }
    it { should be_an_instance_of(Array) }
    its(:size) { should == 2 }
    its(:first) { should == ["multi_json", ">= 1.0.2"]}
    its(:last) { should == ["execjs", ">= 0.3.0"]}
  end

  describe "#collect_gems" do

  end
end

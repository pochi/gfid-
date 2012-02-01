# coding: utf-8

require 'spec_helper'

describe Gfid::Gem do
  let :gem do
    Gfid::Gem.new('uglifier')
  end

  let :gem_with_version do
    Gfid::Gem.new('youroom_api', :version => '0.1.14')
  end

  describe ".initialize" do
    context "can create instance" do
      it "should be instance of Gfid::Gem" do
        gem.should be_a_instance_of(Gfid::Gem)
      end
    end

    describe "can create insance" do
      context "given only gem name" do
        subject { gem }
        its(:name) { should == 'uglifier' }
      end

      context "given gem name and version" do
        subject { gem_with_version }
        its(:name) { should == 'youroom_api' }
        its(:version) { should == '0.1.14' }
      end
    end
  end

  describe "#ask_dependencies" do
    context "description" do
      subject { gem.ask_dependencies }
      it { should be_an_instance_of(Array) }
      its(:size) { should == 2 }
    end

    context "first element" do
      subject { gem.ask_dependencies.first }
      it { should be_a_instance_of(Gfid::Gem) }
      its(:name) { should == "multi_json" }
      its(:version) { should == "1.0.2" }
    end

    context "last element" do
      subject { gem.ask_dependencies.last }
      it { should be_a_instance_of(Gfid::Gem) }
      its(:name) { should == "execjs" }
      its(:version) { should == "0.3.0" }
    end
  end

  context "#download!" do
    it "should receive Rubygems.download! with gem_file_name" do
      Gfid::Rubygems.should_receive(:download).with("youroom_api-0.1.14.gem")
      gem_with_version.download!
    end
  end
end

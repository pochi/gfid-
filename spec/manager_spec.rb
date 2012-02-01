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
      its(:first) { should be_a_instance_of(Gfid::Gem) }
    end
  end
end

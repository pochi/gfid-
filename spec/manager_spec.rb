# coding: utf-8

require 'spec_helper'

describe Gfid::Manager do
  let :manager do
    Gfid::Manager.instance
  end

  describe "#gem_name(name)" do
    before { manager.gem_name("uglifier") }
    subject { manager }
    its(:gems) { should == ["uglifier"] }
  end
end

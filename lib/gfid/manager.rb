# coding: utf-8

module Gfid
  class Manager
    include Singleton
    attr_reader :gems, :dependency_gems
    def initialize
      @gems = []
      @dependency_gems = []
    end

    def gem_name(name, version=nil)
      @gems << Gem.new(name, :verion => version)
    end

    def gems
      @gems
    end
  end
end

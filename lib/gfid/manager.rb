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

    def collect_gems
      @dependency_gems = gems.first.ask_dependencies
      while !dependency_gems.emtpy?

      end
    end
  end
end

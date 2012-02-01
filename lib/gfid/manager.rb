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
      @dependency_gems << gems.first.ask_dependencies
      @dependency_gems.flatten!
    end

    def collect_gems
      while !dependency_gems.empty?
        next_dependency_gems = []
        dependency_gems.flatten.each do |gem|
          @gems << gem
          next_dependency_gems << gem.ask_dependencies
        end
        @dependency_gems = next_dependency_gems.flatten
      end
    end

    def clear!
      @gems = []
      @dependency_gems = []
    end
  end
end

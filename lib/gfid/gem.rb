# coding: utf-8

module Gfid
  class Gem
    attr_reader :name, :version, :dependencies

    def initialize(name, options={ })
      @name = name
      @version = options[:version]
    end

    def ask_dependencies
      res = Rubygems.dependencies(name)
      result = if version
                 res.map { |gem_info| gem_info[:dependencies] if version == gem_info[:number] }
               else
                 # get the newest
                 @version = res.first[:number]
                 res.first[:dependencies]
               end

      result.map do |name, version|
        if name
          version = version.split(" ").last
          self.class.new(name, :version => version)
        end
      end
    end
  end

  class Rubygems
    include HTTParty
    base_uri 'rubygems.org'

    class << self
      def dependencies(gem)
        res = get("/api/v1/dependencies", :query => { :gems => gem } )
        Marshal.load(res.body)
      end
    end
  end
end

# coding: utf-8

module Gfid
  class Gem
    attr_reader :name, :version, :dependencies

    def initialize(name, options={ })
      @name = name
      @version = options[:version]
      # Rubygems.send(:http_proxy, URI(options[:proxy]).host, URI(options[:proxy]).port) if options[:proxy]
    end

    def ask_dependencies
      res = Rubygems.dependencies(@name)
      if @version
        res.each { |gem_info| gem_info[:dependencies] if @version == gem_info[:number] }
      else
        res.first[:dependencies]
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

# coding: utf-8

module Gfid
  class Gem
    attr_reader :name, :dependencies

    def initialize(name, options={ })
      @name = name
      @version = options[:version]
    end

    def ask_dependencies
      res = Rubygems.dependencies(name)
      result = if version
                 res.select { |gem_info| version == gem_info[:number] }.first[:dependencies]
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

    def version
      return nil unless @version
      if @version.split(".").size == 3
        @version
      elsif @version.split(".").first == "0"
        @version + ".1"
      else
        @version + ".0"
      end
    end

    def download!
      Rubygems.download(filename)
    end

    def filename
      name + "-" + version + ".gem"
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

      def download(path)
        get("/downloads/#{path}")
      end
    end
  end
end

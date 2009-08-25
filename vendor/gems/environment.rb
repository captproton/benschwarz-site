# DO NOT MODIFY THIS FILE
module Bundler
  dir = File.dirname(__FILE__)

  ENV["GEM_HOME"] = dir
  ENV["GEM_PATH"] = dir
  ENV["PATH"]     = "#{dir}/../../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{__FILE__} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/sinatra-0.9.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/sinatra-0.9.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/haml-2.0.9/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/haml-2.0.9/lib")

  @gemfile = "#{dir}/../../Gemfile"

  require "rubygems"

  @bundled_specs = {}
  @bundled_specs["haml"] = eval(File.read("#{dir}/specifications/haml-2.0.9.gemspec"))
  @bundled_specs["haml"].loaded_from = "#{dir}/specifications/haml-2.0.9.gemspec"
  @bundled_specs["sinatra"] = eval(File.read("#{dir}/specifications/sinatra-0.9.4.gemspec"))
  @bundled_specs["sinatra"].loaded_from = "#{dir}/specifications/sinatra-0.9.4.gemspec"
  @bundled_specs["rack"] = eval(File.read("#{dir}/specifications/rack-1.0.0.gemspec"))
  @bundled_specs["rack"].loaded_from = "#{dir}/specifications/rack-1.0.0.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env ; end
      def method_missing(*) ; end
      def gem(name, *args)
        opt = args.last || {}
        only = opt[:only] || opt["only"]
        except = opt[:except] || opt["except"]
        files = opt[:require_as] || opt["require_as"] || name

        return unless !only || [only].flatten.any? {|e| e.to_s == @env }
        return if except && [except].flatten.any? {|e| e.to_s == @env }

        files.each { |f| require f }
        yield if block_given?
        true
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile))
  end
end

module Gem
  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end

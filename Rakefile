require File.join(File.dirname(__FILE__), "app")
require 'spec/rake/spectask'

task :default => :spec

desc "Run RSpec test suite"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['-O spec/spec.opts']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Run RSpec over models only"
Spec::Rake::SpecTask.new("spec:models") do |t|
  t.spec_opts = ['-O spec/spec.opts']
  t.spec_files = FileList['spec/models/*_spec.rb']
end
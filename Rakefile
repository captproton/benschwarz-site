require File.join(File.dirname(__FILE__), "app")
require 'spec/rake/spectask'
Dir["#{File.dirname(__FILE__)}/lib/rake/*.rake"].each &method(:require)

task :environment => "db:connect"

namespace :db do
  task :connect do
    Application.new
  end
  
  desc "Auto migrate the database"
  task :migrate => :connect do
    DataMapper.auto_migrate!
  end
end

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

# ===========
# = Twitter =
# ===========
require 'twitter'

namespace :twitter do
  desc 'Import from twitter'
  task :sync => :environment do
    @tweet = Tweet.first :order => [:created_at.desc]
    query = Twitter::Search.new.from('benschwarz')
    query.send(:since, @tweet.source.external_id) unless @tweet.nil?
    query.each do |tweet|
      next unless tweet["to_user_id"].nil?
      t = Tweet.new(:description => tweet["text"])
      puts tweet.inspect
      t.source = Source.new(
        :location => "Twitter", 
        :href => "http://twitter.com/benschwarz/statuses/#{tweet['id']}",
        :external_id => tweet["id"]
      )
      t.save!
    end
  end
end

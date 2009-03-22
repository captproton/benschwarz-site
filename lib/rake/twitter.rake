require 'twitter'

desc 'Import from twitter'
task :sync do
  Twitter.first :order => "created_at desc"
  Twitter::Search.new.from('benschwarz').since('1353946167').each { |r| puts r.id }
end
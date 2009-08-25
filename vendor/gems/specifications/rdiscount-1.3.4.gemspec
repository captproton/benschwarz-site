# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rdiscount}
  s.version = "1.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Tomayko", "Andrew White"]
  s.date = %q{2009-03-04}
  s.default_executable = %q{rdiscount}
  s.email = %q{r@tomayko.com}
  s.executables = ["rdiscount"]
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["COPYING"]
  s.files = ["COPYING", "README.markdown", "Rakefile", "bin/rdiscount", "ext/Csio.c", "ext/amalloc.h", "ext/config.h", "ext/cstring.h", "ext/docheader.c", "ext/dumptree.c", "ext/extconf.rb", "ext/generate.c", "ext/markdown.c", "ext/markdown.h", "ext/mkdio.c", "ext/mkdio.h", "ext/rdiscount.c", "ext/resource.c", "ext/toc.c", "lib/markdown.rb", "lib/rdiscount.rb", "rdiscount.gemspec", "test/benchmark.rb", "test/benchmark.txt", "test/markdown_test.rb", "test/rdiscount_test.rb"]
  s.homepage = %q{http://github.com/rtomayko/rdiscount}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{wink}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Fast Implementation of Gruber's Markdown in C}
  s.test_files = ["test/markdown_test.rb", "test/rdiscount_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

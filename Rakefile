require 'bundler'
require 'bundler/gem_tasks'
require 'rake/clean'

GEMSPEC = Gem::Specification.load('maybe.rb.gemspec')

CLEAN.include(
  'coverage',
  'yardoc',
  'tmp'
)

Dir['./task/*.rake'].each do |task|
  import(task)
end

task :default => :test

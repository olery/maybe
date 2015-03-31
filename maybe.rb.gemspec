require File.expand_path('../lib/maybe/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'maybe.rb'
  gem.version     = Maybe::VERSION
  gem.authors     = ['Olery B.V.']
  gem.email       = 'development@olery.com'
  gem.summary     = 'A basic maybe monad in Ruby'
  gem.homepage    = 'https://github.com/olery/maybe/'
  gem.description = gem.summary
  gem.license     = 'MIT'

  gem.files = Dir.glob([
    'doc/**/*',
    'lib/**/*.rb',
    'README.md',
    'LICENSE',
    'maybe.rb.gemspec',
    '.yardopts'
  ]).select { |file| File.file?(file) }

  gem.has_rdoc              = 'yard'
  gem.required_ruby_version = '>= 1.9.3'

  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'kramdown'
  gem.add_development_dependency 'simplecov'
end

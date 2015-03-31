require 'rspec'

if ENV['COVERAGE']
  require_relative 'support/simplecov'
end

require_relative '../lib/maybe'
require_relative '../lib/maybe/pollute'

RSpec.configure do |config|
  config.color = true

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

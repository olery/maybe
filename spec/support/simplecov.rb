require 'simplecov'

SimpleCov.configure do
  root         File.expand_path('../../../', __FILE__)
  command_name 'rspec'
  project_name 'maybe'

  add_filter 'spec'
  add_filter 'lib/maybe/version'
end

SimpleCov.start

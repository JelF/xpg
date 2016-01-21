require_relative '../bin/environment'

if ENV['COVERAGE_ROOT']
  require 'simplecov'
  SimpleCov.start do
    minimum_coverage 100
    coverage_dir ENV['COVERAGE_ROOT']
    add_group 'Library', 'lib'
    add_filter '/spec/'
  end
end

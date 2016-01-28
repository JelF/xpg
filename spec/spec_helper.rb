if ENV['COVERAGE_ROOT']
  require 'simplecov'
  SimpleCov.start do
    minimum_coverage 100
    coverage_dir ENV['COVERAGE_ROOT']
    add_group 'Library', 'lib'
    add_filter '/spec/'
  end
end

require_relative '../bin/environment'
require 'xpg/rspec_exts'
Dir[XPG::ROOT.join('spec/support/**/*.rb')].each(&method(:require))

RSpec.configure do |config|
  dbname = setup_connection!
  ActiveRecord::Migration.descendants.each { |x| x.new.up }
  config.after(:suite) { close_connection!(dbname) }

  config.around(:each) do |example|
    ActiveRecord::Base.transaction(&example)
  end
end

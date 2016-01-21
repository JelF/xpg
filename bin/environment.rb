require 'bundler/setup'
require 'pry'
require 'xpg'
require 'active_support/all'

require 'pathname'

module XPG
  ROOT = Pathname.new(__FILE__).join('../..')
end

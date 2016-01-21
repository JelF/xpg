require 'bundler/setup'
require 'xpg'
require 'pry'
require 'active_support/all'

require 'pathname'

module XPG
  ROOT = Pathname.new(__FILE__).join('../..')
end

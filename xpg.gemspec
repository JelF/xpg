# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundler/setup'
require 'xpg/version'

Gem::Specification.new do |spec|
  spec.name = 'xpg'
  spec.version = XPG::VERSION
  spec.authors = ['Alexander Smirnov']
  spec.email = ['begdory4@gmail.com']

  spec.summary = <<-TEXT.gsub(/\s+/, ' ')
    XPG gem is an ORM built on the top of ActiveRecord stack
  TEXT

  spec.description = <<-TEXT.gsub(/\s+/, ' ')
    XPG gem is an ORM built on the top of ActiveRecord Stack.
    It allows to write any pg expression in AR way, which make it
    much less stunning, than Sequel or other DSL-based ORM.
    XPG also provides XQuery extension (as for 1.0.0)
  TEXT

  spec.homepage = 'https://github.com/jelf/xpg'

  spec.files = `git ls-files -z`.split("\x0")
               .reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 4.2'
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'pg', '~> 0.18'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.35'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'launchy'
end

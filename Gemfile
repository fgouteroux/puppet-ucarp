source ENV['GEM_SOURCE'] || "https://rubygems.org"

gem 'rake'
gem 'puppetlabs_spec_helper'
gem 'puppet-lint'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

# vim:ft=ruby

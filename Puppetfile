# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.13.0"

# Support for default hiera data in modules

github "module_data", "0.0.4", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "brewcask",    "0.0.10"
github "dnsmasq",     "2.0.4"
github "foreman",     "1.2.0"
# mod "gcc", "0.0.1", :git => "https://github.com/boxen/puppet-gcc.git", :ref => "abc7639"
github "git",         "2.13.0"
github "go",          "2.1.0"
github "homebrew",    "2.1.0"
github "hub",         "1.4.5"
github "inifile",     "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",       "1.9.0"
github "nodejs",      "5.0.9"
github "openssl",     "1.0.0"
github "phantomjs",   "3.0.0"
github "pkgconfig",   "1.0.0"
github "repository",  "2.4.1"
github "ruby",        "8.6.0"
github "stdlib",      "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",        "1.0.0"
github "xquartz",     "1.2.1"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.
github "atom",        "1.3.0"
github "arduino",     "1.0.3", :repo => "mpherg/puppet-arduino"
github "cmake",       "1.0.1"
github "chrome",      "1.2.0"
github "docker",      "1.0.0"
github "dropbox",     "1.4.1"
github "handbrake",   "1.0.4", :repo => "mpherg/puppet-handbrake"
github "iterm2",      "1.2.6", :repo => "mpherg/puppet-iterm2"
github "kubectl",     "1.0.3", :repo => "jenscobie/puppet-kubectl"
github "mactex",      "0.1.0", :repo => "omegaice/puppet-mactex"
github "macvim",      "1.0.0"
github "ohmyzsh",     "1.0.0", :repo => "erivello/puppet-ohmyzsh"
github "osx",         "2.8.0"
github "spectacle",   "1.0.1", :repo => "mpherg/puppet-spectacle"
github "tmux",        "1.0.2"
github "vagrant",     "3.3.4"
github "virtualbox",  "1.0.13"
github "zsh",         "1.0.0"

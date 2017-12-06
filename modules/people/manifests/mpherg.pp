class people::mpherg {
  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  repository { "${dotfiles}":
    source  => 'mpherg/dotfiles'
  }

  include arduino
  include cmake
  include chrome
  include dropbox
  include handbrake

  include iterm2::stable
  include iterm2::colors::solarized_light
  include iterm2::colors::solarized_dark

  include kubectl
  #  include mactex::full
  include macvim
  include ohmyzsh
  include xquartz

  include osx::global::enable_keyboard_control_access
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::global::disable_remote_control_ir_receiver
  include osx::global::tap_to_click
  include osx::finder::show_all_on_desktop
  include osx::finder::no_file_extension_warnings
  include osx::no_network_dsstores
  class { 'osx::global::key_repeat_delay':
    delay => 25
  }
  class { 'osx::global::key_repeat_rate':
    rate => 2
  }
  osx::recovery_message {
    'If this Mac is found, please call 801-888-4162':
  }

  include spectacle
  include tmux
  include vagrant
  include virtualbox
  include zsh

  # Atlassian SDK development
  homebrew::tap { [
    'atlassian/tap',
    'loopperfect/lp',
    'facebook/fb',
    ]:
    ensure => 'present'
  }

  package { 'atlassian/tap/atlassian-plugin-sdk':
    ensure  => present,
    require => Homebrew::Tap['atlassian/tap']
  }


  # Buckaroo
  package { 'loopperfect/lp/buckaroo':
    ensure  => present,
    require => Homebrew::Tap['loopperfect/lp']
  }

  # Various homebrew packages
  package { [
    'boost',
    'clang-format',
    'conan',
    'dep',
    'dos2unix',
    'eigen',
    'gpg',
    'groovy',
    'httpie',
    'jq',
    'maven',
    'ninja',
    'pinentry-mac',
    'pv',
    'python3',
    'reattach-to-user-namespace',
    'tree',
    'watch',
    ]:
    ensure => 'present'
  }

  # Caskroom packages
  package { [
      'aerial',
      'eclipse-java',
      'gimp',
      'intellij-idea',
      'java',
    ]:
    ensure => present,
    provider => 'brewcask',
  }

  # Make sure our python site-packages refers to boxen
  file { [
    "${home}/Library",
    "${home}/Library/Python",
    "${home}/Library/Python/2.7",
    "${home}/Library/Python/2.7/site-packages" ]:
      ensure => directory,
      owner  => "${::boxen_user}",
  }

  file { "${home}/Library/Python/2.7/site-packages/homebrew.pth":
    content => template('people/homebrew.pth.erb'),
    owner   => "${::boxen_user}",
    require => File["${home}/Library/Python/2.7/site-packages"],
  }

  # GNU Radio package (without jack support)
  #  homebrew::tap { 'mpherg/tap': }
  #  package { 'mpherg/tap/gnuradio':
  #    ensure          => 'present',
  #    install_options => [
  #      '--with-documentation',
  #      '--without-jack',
  #    ],
  #    require         => File["${home}/Library/Python/2.7/site-packages/homebrew.pth"],
  #  }

  ruby_gem { 'bundler for all rubies':
    gem          => 'bundler',
    version      => '~> 1.0',
    ruby_version => '*',
  }

  ruby_gem { 'cocoapods':
    gem          => 'cocoapods',
    ruby_version => '2.0.0',
  }
}

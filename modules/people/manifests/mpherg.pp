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

  include java
  include kubectl
  include mactex::full
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
    'neovim/neovim'
    ]:
    ensure => 'present'
  }

  package { 'atlassian/tap/atlassian-plugin-sdk':
    ensure  => present,
    require => Homebrew::Tap['atlassian/tap']
  }

  # Neovim
  package { 'neovim/neovim/neovim':
    ensure  => present,
    require => Homebrew::Tap['neovim/neovim']
  }

  # Neovim requires .vim/.vimrc to be in a separate location
  file { "${home}/.config":
    ensure => 'directory',
  }
  file { "${home}/.config/nvim":
    ensure  => 'link',
    target  => "${home}/.vim",
    require => [ File["${home}/.config"], Repository["${dotfiles}"] ],
  }
  file { "${home}/.config/nvim/init.vim":
    ensure => 'link',
    target => "${home}/.vimrc",
    require => [ File["${home}/.config"], Repository["${dotfiles}"] ],
  }

  # Various homebrew packages
  package { [
    'boost',
    'clang-format',
    'conan',
    'dos2unix',
    'eigen',
    'gpg',
    'maven',
    'python3',
    'tree',
    ]:
    ensure => 'present'
  }

  # Caskroom packages
  package { [
      'aerial',
      'eclipse-java',
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

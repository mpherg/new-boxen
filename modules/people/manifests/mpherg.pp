class people::mpherg {
  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  repository { $dotfiles:
    source  => 'mpherg/dotfiles'
  }

  include arduino
  include cmake
  include chrome
  include docker
  include dropbox
  include gpg
  include handbrake

  include iterm2::stable
  include iterm2::colors::solarized_light
  include iterm2::colors::solarized_dark

  include java
  include mactex::full
  include macvim
  include ohmyzsh

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
  homebrew::tap { 'atlassian/tap': }
  package { 'atlassian/tap/atlassian-plugin-sdk':
    ensure  => present,
    require => Homebrew::Tap['atlassian/tap']
  }

  # Various homebrew packages
  package { [
    'boost',
    'clang-format',
    'dos2unix',
    'eigen',
    'maven',
    'tree'
    ]:
    ensure => 'present'
  }

  # GNU Radio package (without jack support)
  package { 'gnuradio':
    ensure          => 'present',
    install_options => [
      '--with-documentation',
      '--without-jack',
    ],
  }

  ruby_gem { 'bundler for all rubies':
    gem          => 'bundler',
    version      => '~> 1.0',
    ruby_version => '*',
  }
}

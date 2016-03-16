# == Class: repo_epel
#
# Configure the CentOS 5 or 6 repositories and import GPG keys
#
# === Parameters:
#
# $repourl::                       The base repo URL, if not specified defaults to the
#                                  EPEL Mirror
#                                  
# $enable_epel::                   Enable the EPEL Repo
#                                  type:boolean
#
# $enable_debuginfo::              Enable the EPEL Debuginfo Repo
#                                  type:boolean
#
# $enable_source::                 Enable the EPEL source Repo
#                                  type:boolean
#
# $enable_testing::                Enable the EPEL testing Repo
#                                  type:boolean
#
# $enable_testing_debuginfo::      Enable the EPEL testing debuginfo Repo
#                                  type:boolean
#
# $enable_testing_source::         Enable the EPEL testing source Repo
#                                  type:boolean
#
# === Usage:
# * Simple usage:
#
#  include repo_epel
#
# * Advanced usage:
#
#   class {'repo_epel':
#     repourl       => 'http://myrepo/epel',
#     enable_testing    => true,
#   }
#
# * Alternate usage via hiera YAML:
#
#   repo_epel::repourl: 'http://myrepo/epel'
#   repo_epel::enable_testing: true
#
class repo_epel (
    $repourl                       = $repo_epel::params::repourl,
    $enable_epel                   = $repo_epel::params::enable_epel,
    $enable_debuginfo              = $repo_epel::params::enable_debuginfo,
    $enable_source                 = $repo_epel::params::enable_source,
    $enable_testing                = $repo_epel::params::enable_testing,
    $enable_testing_debuginfo      = $repo_epel::params::enable_testing_debuginfo,
    $enable_testing_source         = $repo_epel::params::enable_testing_source,
  ) inherits repo_epel::params {

  validate_string($repourl)
  validate_bool($enable_epel)
  validate_bool($enable_debuginfo)
  validate_bool($enable_source)
  validate_bool($enable_testing)
  validate_bool($enable_testing_debuginfo)
  validate_bool($enable_testing_source)
  
  if $::osfamily == 'RedHat' {
    include repo_epel::epel
    
    repo_epel::rpm_gpg_key{ "RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}":
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
    }

    file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}":
      ensure => present,
      owner  => 0,
      group  => 0,
      mode   => '0644',
      source => "puppet:///modules/repo_epel/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
    }

  } else {
      notice ("Your operating system ${::operatingsystem} does not need EPEL repositories")
  }

}

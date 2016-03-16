# Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special
# Interest Group that creates, maintains, and manages a high quality
# set of additional packages for Enterprise Linux, including, but
# not limited to, Red Hat Enterprise Linux (RHEL),CentOS and
# Scientific Linux (SL).
class repo_epel::epel inherits repo_epel {

  #file { "/etc/yum.repos.d/epel${::operatingsystemmajrelease}.repo": ensure => absent, }
  if $repo_epel::enable_epel {
    $enabled = 1
  } else {
    $enabled = 0
  }

  yumrepo { 'epel':
    baseurl  => "${repourl}/${urlbit}/${::architecture}",
    descr    => "Extra Packages for Enterprise Linux (EPEL) Repository - EL${::operatingsystemmajrelease} - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
  }

}

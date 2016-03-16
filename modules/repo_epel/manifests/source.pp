# Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special
# Interest Group that creates, maintains, and manages a high quality
# set of additional packages for Enterprise Linux, including, but
# not limited to, Red Hat Enterprise Linux (RHEL),CentOS and
# Scientific Linux (SL).
class repo_epel::source inherits repo_epel {

  if $repo_epel::enable_source {
    $enabled = 1
  } else {
    $enabled = 0
  }

  yumrepo { 'epel-source':
    baseurl  => "${repourl}/${urlbit}/${::architecture}/SRPMS",
    descr    => "Extra Packages for Enterprise Linux (EPEL) Repository - EL${::operatingsystemmajrelease} - ${::architecture} - Source",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
  }

}

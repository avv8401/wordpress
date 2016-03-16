# Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special
# Interest Group that creates, maintains, and manages a high quality
# set of additional packages for Enterprise Linux, including, but
# not limited to, Red Hat Enterprise Linux (RHEL),CentOS and
# Scientific Linux (SL).
#
# epel-testing is for packages not yet deemed stable
class repo_epel::testing_source inherits repo_epel {

  if $repo_epel::enable_testing_source {
    $enabled = 1
  } else {
    $enabled = 0
  }

  yumrepo { 'epel-testing-source':
    baseurl  => "${repourl}/testing/${urlbit}/${::architecture}/source",
    descr    => "Extra Packages for Enterprise Linux (EPEL) Repository - Testing - EL${::operatingsystemmajrelease} - ${::architecture} - Source",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
  }

}

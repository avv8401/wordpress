# Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special
# Interest Group that creates, maintains, and manages a high quality
# set of additional packages for Enterprise Linux, including, but
# not limited to, Red Hat Enterprise Linux (RHEL),CentOS and
# Scientific Linux (SL).
#
# epel-testing is for packages not yet deemed stable
class repo_epel::testing inherits repo_epel {

  if $repo_epel::enable_testing {
    $enabled = 1
  } else {
    $enabled = 0
  }

  yumrepo { 'epel-testing':
    #baseurl     => "${repourl}/testing/${urlbit}/${::architecture}",
    mirrorlist  => "http://mirrors.fedoraproject.org/metalink?repo=testing-epel${urlbit}&arch=${::architecture}",


    descr    => "Extra Packages for Enterprise Linux (EPEL) Repository - Testing - EL${::operatingsystemmajrelease} - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
  }

}

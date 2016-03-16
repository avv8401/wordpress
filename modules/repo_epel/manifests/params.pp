# Optional parameters in setting up CentOS Yum repository
class repo_epel::params {
  #$repourl = $::lsbmajdistrelease ? {
  #  5         => 'mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=$basearch',
  #  6         => 'mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
  #  7         => 'mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch',
  #  default   => undef,
  #}
  $enable_epel               = true
  $enable_debuginfo          = false
  $enable_source             = false
  $enable_testing            = true
  $enable_testing_debuginfo  = false
  $enable_testing_source     = false
  $ostype                    = 'EL'
  $urlbit                    = "${::operatingsystemmajrelease}"
  $repourl                   = "http://download.fedoraproject.org/pub/epel"
}

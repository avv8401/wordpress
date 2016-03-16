# repo_epel

# About
Configures the Extra Packages for Enterprise Linux (EPEL) repository
on Enterprise Linux (RHEL, CentOS) clients

"Extra Packages for Enterprise Linux (EPEL) is a Fedora Special
Interest Group that creates, maintains, and manages a high quality
set of additional packages for Enterprise Linux, including, but
not limited to, Red Hat Enterprise Linux (RHEL),CentOS and
Scientific Linux (SL)."
http://fedoraproject.org/wiki/EPEL

## New in 1.0.3
  * Documentation cleanup of the README.md file
  * Removed accidently included ELRepo GPG key

## New in 1.0.2
  * Fixed some typo related bugs
  * Added the debuginfo, source, testing-debuginfo and testing-source repos
  * Removed some manifest files that were accidently included in 1.0.1 that are not related to repo_epel

## New in 1.0.1
  * Updated the module to allow for complete parameterization

## New in 0.1.0
  * Initial release. This module is based on the following puppetlabs module: http://github.com/stahnma/puppet-module-puppetlabs_yum

# Testing
  * This was tested on CentOS 5, 6 and 7 clients
  * Tested using Puppet 3.6.2

# Usage
  * Simple usage:
```
include repo_epel
```
  * Advanced usage:
```
class {'repo_epel':
  repourl       => 'http://myrepo/epel',
  enable_testing    => true,
}
```
  * Alternate usage via hiera YAML:
```
repo_epel::repourl: 'http://myrepo/epel'
repo_epel::enable_testing: true
```
# License
Apache Software License 2.0

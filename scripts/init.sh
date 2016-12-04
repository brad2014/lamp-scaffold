#!/bin/sh

#
# Development Environment Initialization Script
# Assumes vagrant box is a minimal CentOS-7 system.
#
# TODO: Adjust /etc/yum.repos.d/CentOS-Base.repo to point to local repo.
#

# Note: only update if puppet is not yet installed.
if [ ! -d /etc/puppet ] ; then
  echo 'Installing puppet and updating.  Expect key warnings.'
  /bin/yum -q makecache fast
  /bin/yum -y -q install deltarpm epel-release
  /bin/yum -y -q install puppet
  /bin/yum -y -q update mariadb-server

  # Note: if kernel is updated, then VirtualBox drivers must be re-installed
  /bin/yum -y -q update -x 'kernel*'

  # Any standard puppet modules that are generally needed can be installed here.
  # We can also "git clone" puppet modules created locally but not under
  # development in this VM into /etc/puppet/modules
  # For LAMP stack:
  puppet module install puppetlabs/mysql
  puppet module install puppetlabs/apache
  puppet module install willdurand/composer
fi

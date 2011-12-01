class puppet::atboot {
    include settings

    # create a service
    case $operatingsystem {
        CentOS: {
            file {
                "/etc/init.d/puppet":
                    mode => 0755,
                    source => "puppet:///puppet/puppet-centos-initd";
                "/etc/sysconfig/puppet":
                    content => template("puppet/sysconfig-puppet.erb");
            }

            service {
                "puppet":
                    require => [
                        File['/etc/init.d/puppet'],
                        File['/etc/sysconfig/puppet']
                    ],
                    # note we do not try to run the service (running)
                    enable => true;
            }
        }

        default: {
            fail("puppet::atboot support missing for $operatingsystem")
        }
    }
}

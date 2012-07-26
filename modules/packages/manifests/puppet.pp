class packages::puppet {
    $puppet_version = "2.7.11"
    $puppet_rpm_version = "${puppet_version}-2.el6"
    $facter_version = "1.6.10"

    case $operatingsystem{
        CentOS: {
            package {
                "puppet":
                    ensure => "$puppet_rpm_version";
                # puppet this pulls the required version of facter
            }
        }
        Darwin: {
            # These DMGs come directly from http://downloads.puppetlabs.com/mac/
            packages::pkgdmg {
                puppet:
                    version => $puppet_version;
                facter:
                    version => $facter_version;
            }
        }
        default: {
            fail("cannot install on $operatingsystem")
        }
    }
}
class packages::httpd {
    case $operatingsystem {
        CentOS: {
            package {
                "httpd":
                    ensure => latest;
            }
        }

        Darwin: {
            # installed by default
        }

        default: {
            fail("cannot install on $operatingsystem")
        }
    }
}

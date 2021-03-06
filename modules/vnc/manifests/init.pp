class vnc {
    include vnc::appearance
    include users::builder

    case $::operatingsystem {
        Darwin: {
            osxutils::defaults {
                # kickstart -configure -allowAccessFor -allUsers
                ARD_AllLocalUsers:
                    domain => "/Library/Preferences/com.apple.RemoteManagement",
                    key => "ARD_AllLocalUsers",
                    value => "1";
                # kickstart -configure -privs -all -access -on
                # (this doesn't work; see https://bugzilla.mozilla.org/show_bug.cgi?id=733534#c8)
            }
            service {
                # kickstart -activate
                'com.apple.screensharing':
                    enable => true,
                    ensure => running,
            }
            $kickstart = "/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
            exec {
                #allow builder user to connect via screensharing
                "enable-remote-builduser-access":
                 command => "$kickstart -configure -allowAccessFor -specifiedUsers; $kickstart -activate -configure -access -on -users $::users::builder::username -privs -all -restart -agent -menu",
                 refreshonly => true;         
            }
        }
        default: {
            fail("Cannot set up VNC on this platform")
        }
    }
}

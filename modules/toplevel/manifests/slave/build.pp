class toplevel::slave::build inherits toplevel::slave {
    include ntp::daemon
    include packages::mozilla-tools
}

